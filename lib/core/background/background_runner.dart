import 'package:workmanager/workmanager.dart';

import '../database/app_database.dart';
import '../services/backup_engine.dart';
import '../services/notification_service.dart';
import '../services/secure_storage_service.dart';

/// The WorkManager callback dispatcher.
///
/// Must be a top-level function annotated with `@pragma('vm:entry-point')`
/// so the Dart AOT compiler keeps it alive for the background isolate.
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    final jobId = inputData?['jobId'] as int?;
    if (jobId == null) return false;

    final db = AppDatabase();
    final notif = NotificationService();

    try {
      await notif.init();
      final engine = BackupEngine(
        db: db,
        storage: SecureStorageService(),
        notif: notif,
      );
      await engine.runJob(jobId);
      return true;
    } catch (_) {
      return false;
    } finally {
      await db.close();
    }
  });
}
