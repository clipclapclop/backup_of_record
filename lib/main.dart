import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workmanager/workmanager.dart';
import 'app.dart';
import 'core/background/background_runner.dart';
import 'core/database/app_database.dart';
import 'core/services/notification_service.dart';
import 'core/services/scheduling_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  await Workmanager().initialize(callbackDispatcher);

  // Clean up stale runs and re-sync schedules on each launch.
  // If the app was killed mid-backup, those runs are still marked "running"
  // in the DB — fix them before the UI ever sees them.
  final db = AppDatabase();
  try {
    final cleaned = await db.runsDao.markStaleRunsFailed();
    if (cleaned > 0) {
      debugPrint('[main] Marked $cleaned stale run(s) as failed');
    }
    await SchedulingService.syncAllJobs(db);
  } finally {
    await db.close();
  }

  runApp(const ProviderScope(child: BackupApp()));
}
