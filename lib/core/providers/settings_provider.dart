import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/app_database.dart';
import 'database_provider.dart';

final settingsProvider = FutureProvider<GlobalSetting?>((ref) async {
  final db = ref.watch(databaseProvider);
  return db.settingsDao.getSettings();
});
