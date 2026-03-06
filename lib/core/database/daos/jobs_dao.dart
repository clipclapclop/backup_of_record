import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/jobs_table.dart';

part 'jobs_dao.g.dart';

@DriftAccessor(tables: [Jobs])
class JobsDao extends DatabaseAccessor<AppDatabase> with _$JobsDaoMixin {
  JobsDao(super.db);

  Stream<List<Job>> watchAllJobs() => select(jobs).watch();

  Future<List<Job>> getAllJobs() => select(jobs).get();

  Future<Job?> getJob(int id) =>
      (select(jobs)..where((j) => j.id.equals(id))).getSingleOrNull();

  Future<int> insertJob(JobsCompanion entry) => into(jobs).insert(entry);

  Future<bool> updateJob(JobsCompanion entry) => update(jobs).replace(entry);

  Future<int> deleteJob(int id) =>
      (delete(jobs)..where((j) => j.id.equals(id))).go();

  Future<void> updateLastRun(int jobId, DateTime at, String status) =>
      (update(jobs)..where((j) => j.id.equals(jobId))).write(
        JobsCompanion(
          lastRunAt: Value(at),
          lastRunStatus: Value(status),
        ),
      );
}
