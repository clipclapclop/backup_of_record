import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/app_database.dart';
import 'database_provider.dart';

final jobsProvider = StreamProvider<List<Job>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.jobsDao.watchAllJobs();
});
