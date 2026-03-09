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

  // Re-sync all job schedules on each launch (WorkManager state can be lost
  // after app updates, device reboots on some OEMs, etc.)
  final db = AppDatabase();
  try {
    await SchedulingService.syncAllJobs(db);
  } finally {
    await db.close();
  }

  runApp(const ProviderScope(child: BackupApp()));
}
