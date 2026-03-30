import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/file_records_table.dart';
import '../tables/file_run_logs_table.dart';
import '../tables/in_progress_uploads_table.dart';

part 'files_dao.g.dart';

@DriftAccessor(tables: [FileRecords, FileRunLogs, InProgressUploads])
class FilesDao extends DatabaseAccessor<AppDatabase> with _$FilesDaoMixin {
  FilesDao(super.db);

  // ── FileRecords ──────────────────────────────────────────────────────────

  Future<List<FileRecord>> getFilesForJob(int jobId) =>
      (select(fileRecords)..where((f) => f.jobId.equals(jobId))).get();

  Future<FileRecord?> getFileRecord(int jobId, String relativePath) =>
      (select(fileRecords)
            ..where((f) =>
                f.jobId.equals(jobId) & f.relativePath.equals(relativePath))
            ..limit(1))
          .getSingleOrNull();

  Future<int> upsertFileRecord(FileRecordsCompanion entry) =>
      into(fileRecords).insert(
        entry,
        onConflict: DoUpdate(
          (old) => entry,
          target: [fileRecords.jobId, fileRecords.relativePath],
        ),
      );

  Future<void> deleteFileRecordsForJob(int jobId) =>
      (delete(fileRecords)..where((f) => f.jobId.equals(jobId))).go();

  // ── FileRunLogs ──────────────────────────────────────────────────────────

  Future<List<FileRunLog>> getLogsForRun(int runId) =>
      (select(fileRunLogs)..where((l) => l.runId.equals(runId))).get();

  Stream<List<FileRunLog>> watchLogsForRun(int runId) =>
      (select(fileRunLogs)
            ..where((l) => l.runId.equals(runId))
            ..orderBy([(l) => OrderingTerm.desc(l.occurredAt)]))
          .watch();

  Future<int> insertLog(FileRunLogsCompanion entry) =>
      into(fileRunLogs).insert(entry);

  // ── InProgressUploads ────────────────────────────────────────────────────

  Future<List<InProgressUpload>> getInProgressForJob(int jobId) =>
      (select(inProgressUploads)..where((u) => u.jobId.equals(jobId))).get();

  Stream<List<InProgressUpload>> watchInProgressForJob(int jobId) =>
      (select(inProgressUploads)..where((u) => u.jobId.equals(jobId))).watch();

  Future<int> insertInProgress(InProgressUploadsCompanion entry) =>
      into(inProgressUploads).insert(entry);

  Future<void> deleteInProgress(int id) =>
      (delete(inProgressUploads)..where((u) => u.id.equals(id))).go();

  Future<void> updateBytesUploaded(int id, int bytes) =>
      (update(inProgressUploads)..where((u) => u.id.equals(id))).write(
        InProgressUploadsCompanion(bytesUploaded: Value(bytes)),
      );
}
