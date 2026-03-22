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

  /// Watches all runs that are queued or actively running across all jobs.
  Stream<List<JobRun>> watchAllActiveRuns() =>
      (select(jobRuns)
            ..where((r) =>
                r.status.equals(RunStatus.queued.index) |
                r.status.equals(RunStatus.running.index))
            ..orderBy([(r) => OrderingTerm.asc(r.startedAt)]))
          .watch();

  Future<int> insertRun(JobRunsCompanion entry) =>
      into(jobRuns).insert(entry);

  Future<void> updateRun(JobRunsCompanion entry) =>
      (update(jobRuns)..where((r) => r.id.equals(entry.id.value)))
          .write(entry);

  Future<JobRun?> getActiveRunForJob(int jobId) =>
      (select(jobRuns)
            ..where((r) =>
                r.jobId.equals(jobId) &
                r.status.equals(RunStatus.running.index)))
          .getSingleOrNull();

  /// Returns a pre-inserted queued placeholder for a job, if one exists.
  /// Uses limit(1) to avoid a StateError when duplicate queued rows exist.
  Future<JobRun?> getQueuedRunForJob(int jobId) =>
      (select(jobRuns)
            ..where((r) =>
                r.jobId.equals(jobId) &
                r.status.equals(RunStatus.queued.index))
            ..orderBy([(r) => OrderingTerm.asc(r.startedAt)])
            ..limit(1))
          .getSingleOrNull();

  /// Sets cancelRequested = true on a run so the engine can pick it up.
  Future<void> requestCancel(int runId) => (update(jobRuns)
        ..where((r) => r.id.equals(runId)))
      .write(const JobRunsCompanion(cancelRequested: Value(true)));

  Future<bool> isCancelRequested(int runId) async {
    final run = await (select(jobRuns)
          ..where((r) => r.id.equals(runId)))
        .getSingleOrNull();
    return run?.cancelRequested ?? false;
  }
}
