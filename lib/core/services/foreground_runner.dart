import 'dart:async';
import 'dart:developer' as dev;

import '../database/app_database.dart';
import 'backup_engine.dart';
import 'notification_service.dart';
import 'secure_storage_service.dart';

/// Runs a backup job immediately in the main isolate.
///
/// Use this for user-initiated "Run now" / "Dry run" actions instead of
/// WorkManager, which has multi-minute startup latency.
class ForegroundRunner {
  static BackupEngine? _activeEngine;
  static int? _activeRunJobId;

  /// Whether a backup is currently running.
  static bool get isRunning => _activeEngine != null;
  static int? get activeJobId => _activeRunJobId;

  static void _log(String msg) {
    dev.log('[ForegroundRunner] $msg', name: 'backup');
    // ignore: avoid_print
    print('[ForegroundRunner] $msg');
  }

  /// Runs [jobId] immediately.  The returned [Future] completes when done.
  static Future<void> runNow(
    AppDatabase db,
    int jobId, {
    bool dryRun = false,
  }) async {
    _log('runNow called — jobId=$jobId dryRun=$dryRun');

    final notif = NotificationService();
    await notif.init();
    _log('NotificationService initialized');

    final engine = BackupEngine(
      db: db,
      storage: SecureStorageService(),
      notif: notif,
    );
    _activeEngine = engine;
    _activeRunJobId = jobId;
    _log('BackupEngine created, calling engine.runJob...');

    try {
      await engine.runJob(jobId, dryRun: dryRun, onProgress: (p) {
        _log('progress: ${p.filesProcessed}/${p.totalFiles} — ${p.currentFile}');
      });
      _log('engine.runJob completed normally');
    } catch (e, st) {
      _log('engine.runJob threw: $e\n$st');
      rethrow;
    } finally {
      _activeEngine = null;
      _activeRunJobId = null;
      _log('cleanup done');
    }
  }

  /// Cancel the currently-running backup, if any.
  static void cancel() {
    _activeEngine?.cancel();
  }
}
