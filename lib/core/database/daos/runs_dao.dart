import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/job_runs_table.dart';

part 'runs_dao.g.dart';

@DriftAccessor(tables: [JobRuns])
class RunsDao extends DatabaseAccessor<AppDatabase> with _$RunsDaoMixin {
  RunsDao(super.db);

  Stream<List<JobRun>> watchRunsForJob(int jobId) =>
      (select(jobRuns)
            ..where((r) => r.jobId.equals(jobId))
            ..orderBy([(r) => OrderingTerm.desc(r.startedAt)])
            ..limit(50))
          .watch();

  Future<int> insertRun(JobRunsCompanion entry) =>
      into(jobRuns).insert(entry);

  Future<void> updateRun(JobRunsCompanion entry) =>
      update(jobRuns).replace(entry);

  Future<JobRun?> getActiveRunForJob(int jobId) =>
      (select(jobRuns)
            ..where((r) =>
                r.jobId.equals(jobId) &
                r.status.equals(RunStatus.running.index)))
          .getSingleOrNull();
}
