import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/app_database.dart';
import 'database_provider.dart';

final jobsProvider = StreamProvider<List<Job>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.jobsDao.watchAllJobs();
});

final jobProvider = StreamProvider.family<Job?, int>((ref, id) {
  final db = ref.watch(databaseProvider);
  return db.jobsDao.watchJob(id);
});

final jobRunsProvider = StreamProvider.family<List<JobRun>, int>((ref, jobId) {
  final db = ref.watch(databaseProvider);
  return db.runsDao.watchRunsForJob(jobId);
});
