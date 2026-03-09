import 'dart:io';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart' show Value;
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../database/app_database.dart';
import '../database/tables/file_records_table.dart';
import '../database/tables/file_run_logs_table.dart';
import '../database/tables/job_runs_table.dart';
import '../database/tables/jobs_table.dart';
import 'notification_service.dart';
import 'secure_storage_service.dart';
import 'webdav_service.dart';

// ── Notification flag constants (mirrors settings_screen.dart) ─────────────────
const _kNotifyJobFailed = 0x01;
const _kNotifyFileLocked = 0x02;
const _kNotifyPartialFailure = 0x04;
const _kNotifySuccess = 0x08;
const _kNotifyRetentionCleanup = 0x10;
const _kNotifyLowSpace = 0x20;

// ── Public types ───────────────────────────────────────────────────────────────

class BackupProgress {
  final String currentFile;
  final int filesProcessed;
  final int totalFiles; // 0 = still scanning
  final int bytesTransferred;

  const BackupProgress({
    this.currentFile = '',
    this.filesProcessed = 0,
    this.totalFiles = 0,
    this.bytesTransferred = 0,
  });
}

class BackupCancelledException implements Exception {
  const BackupCancelledException();
}

// ── Internal accumulator ───────────────────────────────────────────────────────

class _Stats {
  int scanned = 0;
  int uploaded = 0;
  int skipped = 0;
  int failed = 0;
  int bytes = 0;
  String? errorSummary;
}

// ── BackupEngine ───────────────────────────────────────────────────────────────

class BackupEngine {
  final AppDatabase _db;
  final SecureStorageService _storage;
  final NotificationService _notif;

  bool _cancelled = false;

  BackupEngine({
    required AppDatabase db,
    required SecureStorageService storage,
    required NotificationService notif,
  })  : _db = db,
        _storage = storage,
        _notif = notif;

  void cancel() => _cancelled = true;

  void _checkCancelled() {
    if (_cancelled) throw const BackupCancelledException();
  }

  // ── Entry point ─────────────────────────────────────────────────────────────

  Future<void> runJob(
    int jobId, {
    bool dryRun = false,
    void Function(BackupProgress)? onProgress,
  }) async {
    _cancelled = false;

    final job = await _db.jobsDao.getJob(jobId);
    if (job == null) return;

    final settings = await _db.settingsDao.getSettings();
    if (settings == null) {
      await _notif.showError(
          'Backup failed', '${job.name}: NAS not configured');
      return;
    }

    final password = await _storage.getNasPassword() ?? '';
    final webdav = WebDavService(
      host: settings.nasHost,
      port: settings.nasPort,
      useHttps: settings.useHttps,
      username: settings.nasUsername,
      password: password,
    );

    // Low-storage warning
    if (settings.spaceWarnThresholdGb > 0) {
      final available = await webdav.getAvailableBytes();
      if (available != null) {
        final thresholdBytes =
            settings.spaceWarnThresholdGb * 1024 * 1024 * 1024;
        if (available < thresholdBytes &&
            (settings.notificationFlags & _kNotifyLowSpace) != 0) {
          await _notif.showInfo(
            'Low NAS storage',
            '${(available / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB remaining',
          );
        }
      }
    }

    final startedAt = DateTime.now();
    final runId = await _db.runsDao.insertRun(JobRunsCompanion(
      jobId: Value(jobId),
      startedAt: Value(startedAt),
      status: Value(dryRun ? RunStatus.dryRun : RunStatus.running),
    ));

    final stats = _Stats();
    RunStatus finalStatus = RunStatus.success;

    try {
      await _recoverStaleParts(job, webdav);
      onProgress?.call(const BackupProgress());

      if (job.jobType == JobType.folderBackup) {
        await _runFolderBackup(job, runId, webdav, stats,
            dryRun: dryRun, onProgress: onProgress);
      } else {
        await _runLivingFile(job, runId, webdav, stats,
            dryRun: dryRun, onProgress: onProgress);
      }

      if (stats.failed > 0 && stats.uploaded > 0) {
        finalStatus = RunStatus.partial;
      } else if (stats.failed > 0) {
        finalStatus = RunStatus.failed;
      } else if (dryRun) {
        finalStatus = RunStatus.dryRun;
      } else {
        finalStatus = RunStatus.success;
      }
    } on BackupCancelledException {
      finalStatus = RunStatus.cancelled;
    } catch (e) {
      finalStatus = RunStatus.failed;
      stats.errorSummary = e.toString();
    } finally {
      webdav.dispose();
    }

    final completedAt = DateTime.now();
    await _db.runsDao.updateRun(JobRunsCompanion(
      id: Value(runId),
      jobId: Value(jobId),
      startedAt: Value(startedAt),
      completedAt: Value(completedAt),
      status: Value(finalStatus),
      filesScanned: Value(stats.scanned),
      filesUploaded: Value(stats.uploaded),
      filesSkipped: Value(stats.skipped),
      filesFailed: Value(stats.failed),
      bytesTransferred: Value(stats.bytes),
      errorSummary: Value(stats.errorSummary),
    ));

    await _db.jobsDao.updateLastRun(jobId, completedAt, finalStatus.name);

    if (!dryRun) {
      await _sendNotification(
          job.name, finalStatus, stats, settings.notificationFlags);
    }
  }

  // ── Crash recovery ──────────────────────────────────────────────────────────

  Future<void> _recoverStaleParts(Job job, WebDavService webdav) async {
    final inProgress = await _db.filesDao.getInProgressForJob(job.id);
    for (final item in inProgress) {
      await webdav.deletePart(item.nasFinalPath);
      await _db.filesDao.deleteInProgress(item.id);
    }
  }

  // ── Type A: Folder backup ───────────────────────────────────────────────────

  Future<void> _runFolderBackup(
    Job job,
    int runId,
    WebDavService webdav,
    _Stats stats, {
    required bool dryRun,
    void Function(BackupProgress)? onProgress,
  }) async {
    final sourceDir = Directory(job.sourcePath);
    if (!sourceDir.existsSync()) {
      throw Exception('Source folder not found: ${job.sourcePath}');
    }

    final allFiles = sourceDir
        .listSync(recursive: true, followLinks: false)
        .whereType<File>()
        .toList();

    // Pre-fetch all file records for this job — one query, O(1) lookups after
    final existingRecords = await _db.filesDao.getFilesForJob(job.id);
    final recordMap = {for (final r in existingRecords) r.relativePath: r};

    // Apply backup strategy filter
    final cutoff = _strategyCutoff(job);
    final files = cutoff != null
        ? allFiles.where((f) {
            final rel = p.relative(f.path, from: job.sourcePath);
            return !recordMap.containsKey(rel) ||
                f.statSync().modified.isAfter(cutoff);
          }).toList()
        : allFiles;

    stats.scanned = files.length;
    int processed = 0;

    for (final file in files) {
      _checkCancelled();

      final relPath =
          p.relative(file.path, from: job.sourcePath).replaceAll('\\', '/');
      final nasBase =
          '${job.destinationNasPath}/$relPath'.replaceAll('//', '/');

      onProgress?.call(BackupProgress(
        currentFile: relPath,
        filesProcessed: processed,
        totalFiles: files.length,
        bytesTransferred: stats.bytes,
      ));

      try {
        final record = recordMap[relPath];
        if (!await _fileNeedsUpload(file, record, job)) {
          stats.skipped++;
          processed++;
          continue;
        }

        if (dryRun) {
          await _log(runId, record?.id, FileAction.uploaded, relPath);
          stats.uploaded++;
          processed++;
          continue;
        }

        final (uploadFile, nasPath) =
            await _compressFile(file, nasBase, job.compressionType);

        // versionOnChange: timestamp suffix if the file was already backed up
        final finalNasPath =
            job.changePolicy == ChangePolicy.versionOnChange && record != null
                ? _timestampPath(nasPath)
                : nasPath;

        final fileSize = await uploadFile.length();
        final inProgressId = await _db.filesDao.insertInProgress(
          InProgressUploadsCompanion(
            jobId: Value(job.id),
            localPath: Value(file.path),
            nasTempPath: Value('$finalNasPath.part'),
            nasFinalPath: Value(finalNasPath),
            totalBytes: Value(fileSize),
            startedAt: Value(DateTime.now()),
          ),
        );

        try {
          final prevBytes = stats.bytes;
          await webdav.uploadFile(
            uploadFile,
            finalNasPath,
            onProgress: (sent, _) {
              onProgress?.call(BackupProgress(
                currentFile: relPath,
                filesProcessed: processed,
                totalFiles: files.length,
                bytesTransferred: prevBytes + sent,
              ));
            },
          );
          stats.bytes += fileSize;
        } finally {
          await _db.filesDao.deleteInProgress(inProgressId);
          if (uploadFile.path != file.path) await uploadFile.delete();
        }

        final stat = file.statSync();
        final hash = job.comparisonMethod != ComparisonMethod.metadata
            ? await _md5(file)
            : null;

        final recordId = await _db.filesDao.upsertFileRecord(
          FileRecordsCompanion(
            jobId: Value(job.id),
            relativePath: Value(relPath),
            nasPath: Value(finalNasPath),
            sizeBytes: Value(stat.size),
            lastModified: Value(stat.modified),
            hash: Value(hash),
            lastBackedUpAt: Value(DateTime.now()),
            lastStatus: const Value(FileStatus.ok),
          ),
        );

        // Update the in-memory map so subsequent checks are accurate
        recordMap[relPath] = FileRecord(
          id: recordId,
          jobId: job.id,
          relativePath: relPath,
          nasPath: finalNasPath,
          sizeBytes: stat.size,
          lastModified: stat.modified,
          hash: hash,
          lastBackedUpAt: DateTime.now(),
          lastStatus: FileStatus.ok,
        );

        await _log(runId, recordId, FileAction.uploaded, relPath);
        stats.uploaded++;
      } catch (e) {
        stats.failed++;
        await _log(runId, null, FileAction.failed, relPath,
            error: e.toString());
      }

      processed++;
    }
  }

  // ── Type B: Living file ─────────────────────────────────────────────────────

  Future<void> _runLivingFile(
    Job job,
    int runId,
    WebDavService webdav,
    _Stats stats, {
    required bool dryRun,
    void Function(BackupProgress)? onProgress,
  }) async {
    final file = File(job.sourcePath);
    if (!file.existsSync()) {
      throw Exception('Source file not found: ${job.sourcePath}');
    }

    stats.scanned = 1;
    final filename = p.basename(job.sourcePath);

    onProgress?.call(BackupProgress(
        currentFile: filename, filesProcessed: 0, totalFiles: 1));

    // Check file is accessible (not locked by another process)
    try {
      final raf = await file.open();
      await raf.close();
    } catch (_) {
      stats.skipped++;
      await _log(runId, null, FileAction.locked, job.sourcePath,
          error: 'File locked or inaccessible');
      final flags =
          (await _db.settingsDao.getSettings())?.notificationFlags ?? 0;
      if ((flags & _kNotifyFileLocked) != 0) {
        await _notif.showInfo('File locked — ${job.name}',
            'Could not access $filename, will retry next run');
      }
      return;
    }

    final record = await _db.filesDao.getFileRecord(job.id, filename);
    if (!await _fileHasChanged(file, record, job.comparisonMethod)) {
      stats.skipped++;
      return;
    }

    final timestamp = DateFormat('yyyy-MM-ddTHH-mm-ss').format(DateTime.now());
    final stem = p.basenameWithoutExtension(job.sourcePath);
    final ext = p.extension(job.sourcePath);

    final (uploadFile, versionedExt) =
        await _compressLiving(file, ext, job.compressionType);
    final nasPath =
        '${job.destinationNasPath}/${stem}_$timestamp$versionedExt';

    if (!dryRun) {
      final fileSize = await uploadFile.length();
      final inProgressId = await _db.filesDao.insertInProgress(
        InProgressUploadsCompanion(
          jobId: Value(job.id),
          localPath: Value(file.path),
          nasTempPath: Value('$nasPath.part'),
          nasFinalPath: Value(nasPath),
          totalBytes: Value(fileSize),
          startedAt: Value(DateTime.now()),
        ),
      );

      try {
        await webdav.uploadFile(uploadFile, nasPath);
        stats.bytes += fileSize;
      } finally {
        await _db.filesDao.deleteInProgress(inProgressId);
        if (uploadFile.path != file.path) await uploadFile.delete();
      }

      final stat = file.statSync();
      final hash = job.comparisonMethod != ComparisonMethod.metadata
          ? await _md5(file)
          : null;

      await _db.filesDao.upsertFileRecord(FileRecordsCompanion(
        jobId: Value(job.id),
        relativePath: Value(filename),
        nasPath: Value(nasPath),
        sizeBytes: Value(stat.size),
        lastModified: Value(stat.modified),
        hash: Value(hash),
        lastBackedUpAt: Value(DateTime.now()),
        lastStatus: const Value(FileStatus.ok),
      ));

      if (job.retentionCount != null || job.retentionDays != null) {
        await _applyRetention(job, webdav, stem, ext, runId);
      }
    }

    await _log(runId, null, FileAction.uploaded, job.sourcePath);
    stats.uploaded++;
  }

  // ── Retention cleanup ───────────────────────────────────────────────────────

  Future<void> _applyRetention(
    Job job,
    WebDavService webdav,
    String stem,
    String originalExt,
    int runId,
  ) async {
    final List<WebDavEntry> versions;
    try {
      final entries = await webdav.listDirectory(job.destinationNasPath);
      versions = entries
          .where((e) =>
              !e.isDirectory &&
              e.name.startsWith('${stem}_') &&
              (e.name.endsWith(originalExt) ||
                  e.name.endsWith('$originalExt.gz') ||
                  e.name.endsWith('$originalExt.zip')))
          .toList()
        ..sort((a, b) => (a.lastModified ?? DateTime(0))
            .compareTo(b.lastModified ?? DateTime(0)));
    } catch (_) {
      return;
    }

    final now = DateTime.now();
    int deleted = 0;

    for (int i = 0; i < versions.length; i++) {
      final v = versions[i];
      bool keep = false;

      // Newest retentionCount entries are at the tail of the sorted list
      if (job.retentionCount != null) {
        keep = keep || i >= versions.length - job.retentionCount!;
      }
      if (job.retentionDays != null) {
        final ageDays = now.difference(v.lastModified ?? DateTime(0)).inDays;
        keep = keep || ageDays <= job.retentionDays!;
      }

      if (!keep) {
        try {
          await webdav.delete('${job.destinationNasPath}/${v.name}');
          await _log(runId, null, FileAction.retentionDeleted,
              '${job.destinationNasPath}/${v.name}');
          deleted++;
        } catch (_) {}
      }
    }

    if (deleted > 0) {
      final flags =
          (await _db.settingsDao.getSettings())?.notificationFlags ?? 0;
      if ((flags & _kNotifyRetentionCleanup) != 0) {
        await _notif.showInfo('Retention cleanup — ${job.name}',
            '$deleted old version(s) deleted');
      }
    }
  }

  // ── Change detection ────────────────────────────────────────────────────────

  Future<bool> _fileNeedsUpload(
      File file, FileRecord? record, Job job) async {
    if (job.changePolicy == ChangePolicy.archiveOnly) {
      return record == null || record.lastStatus != FileStatus.ok;
    }
    return _fileHasChanged(file, record, job.comparisonMethod);
  }

  Future<bool> _fileHasChanged(
      File file, FileRecord? record, ComparisonMethod method) async {
    if (record == null) return true;
    final stat = file.statSync();
    switch (method) {
      case ComparisonMethod.metadata:
        return stat.size != record.sizeBytes ||
            stat.modified != record.lastModified;
      case ComparisonMethod.hash:
        return await _md5(file) != record.hash;
      case ComparisonMethod.hashThenMetadata:
        // Once a hash baseline exists, use metadata for speed on subsequent runs
        if (record.hash != null) {
          return stat.size != record.sizeBytes ||
              stat.modified != record.lastModified;
        }
        return await _md5(file) != record.hash;
    }
  }

  DateTime? _strategyCutoff(Job job) => switch (job.backupStrategy) {
        BackupStrategy.full => null,
        BackupStrategy.fromDate => job.fromDate,
        BackupStrategy.incremental => job.lastRunAt,
      };

  // ── Compression ─────────────────────────────────────────────────────────────

  /// Returns (fileToUpload, finalNasPath). fileToUpload may be a temp file.
  Future<(File, String)> _compressFile(
      File source, String nasBase, CompressionType type) async {
    switch (type) {
      case CompressionType.none:
        return (source, nasBase);
      case CompressionType.gzip:
        final tmp = await _compressToTmp(source, 'gz');
        return (tmp, '$nasBase.gz');
      case CompressionType.zip:
        final tmp = await _compressToTmp(source, 'zip');
        return (tmp, '$nasBase.zip');
    }
  }

  /// Returns (fileToUpload, finalExtension) for living-file uploads.
  Future<(File, String)> _compressLiving(
      File source, String originalExt, CompressionType type) async {
    switch (type) {
      case CompressionType.none:
        return (source, originalExt);
      case CompressionType.gzip:
        final tmp = await _compressToTmp(source, 'gz');
        return (tmp, '$originalExt.gz');
      case CompressionType.zip:
        final tmp = await _compressToTmp(source, 'zip');
        return (tmp, '$originalExt.zip');
    }
  }

  Future<File> _compressToTmp(File source, String ext) async {
    final tmpDir = await getTemporaryDirectory();
    final tmpPath = p.join(tmpDir.path, '${p.basename(source.path)}.$ext.tmp');
    final bytes = await source.readAsBytes();

    final List<int> compressed;
    if (ext == 'gz') {
      compressed = GZipEncoder().encode(bytes)!;
    } else {
      final archive = Archive()
        ..addFile(ArchiveFile(p.basename(source.path), bytes.length, bytes));
      compressed = ZipEncoder().encode(archive)!;
    }

    return File(tmpPath)..writeAsBytesSync(compressed);
  }

  // ── MD5 ─────────────────────────────────────────────────────────────────────

  Future<String> _md5(File file) async {
    final digest = await md5.bind(file.openRead()).first;
    return digest.toString();
  }

  // ── Path helpers ─────────────────────────────────────────────────────────────

  String _timestampPath(String nasPath) {
    final ext = p.extension(nasPath);
    final stem = p.withoutExtension(nasPath);
    final ts = DateFormat('yyyy-MM-ddTHH-mm-ss').format(DateTime.now());
    return '${stem}_$ts$ext';
  }

  // ── Logging ──────────────────────────────────────────────────────────────────

  Future<void> _log(
    int runId,
    int? fileRecordId,
    FileAction action,
    String filePath, {
    String? error,
  }) =>
      _db.filesDao.insertLog(FileRunLogsCompanion(
        runId: Value(runId),
        fileRecordId: Value(fileRecordId),
        action: Value(action),
        filePath: Value(filePath),
        errorMessage: Value(error),
        occurredAt: Value(DateTime.now()),
      ));

  // ── Notifications ─────────────────────────────────────────────────────────

  Future<void> _sendNotification(
      String jobName, RunStatus status, _Stats stats, int flags) async {
    switch (status) {
      case RunStatus.failed:
        if ((flags & _kNotifyJobFailed) != 0) {
          await _notif.showError('Backup failed — $jobName',
              stats.errorSummary ?? 'Unknown error');
        }
      case RunStatus.partial:
        if ((flags & _kNotifyPartialFailure) != 0) {
          await _notif.showError('Partial backup — $jobName',
              '${stats.uploaded} uploaded, ${stats.failed} failed');
        }
      case RunStatus.success:
        if ((flags & _kNotifySuccess) != 0) {
          await _notif.showInfo('Backup complete — $jobName',
              '${stats.uploaded} file(s) · ${_fmtBytes(stats.bytes)}');
        }
      default:
        break;
    }
  }

  String _fmtBytes(int b) {
    if (b < 1024) return '$b B';
    if (b < 1048576) return '${(b / 1024).toStringAsFixed(1)} KB';
    if (b < 1073741824) return '${(b / 1048576).toStringAsFixed(1)} MB';
    return '${(b / 1073741824).toStringAsFixed(2)} GB';
  }
}
