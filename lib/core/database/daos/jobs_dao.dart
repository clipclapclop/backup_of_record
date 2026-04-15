import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/global_settings_table.dart';
import '../tables/jobs_table.dart';

part 'jobs_dao.g.dart';

@DriftAccessor(tables: [Jobs, GlobalSettings])
class JobsDao extends DatabaseAccessor<AppDatabase> with _$JobsDaoMixin {
  JobsDao(super.db);

  Stream<List<Job>> watchAllJobs() => (select(jobs)
        ..orderBy([
          (j) => OrderingTerm.asc(j.sortOrder),
          (j) => OrderingTerm.asc(j.id),
        ]))
      .watch();

  Stream<Job?> watchJob(int id) =>
      (select(jobs)..where((j) => j.id.equals(id))).watchSingleOrNull();

  Future<List<Job>> getAllJobs() => (select(jobs)
        ..orderBy([
          (j) => OrderingTerm.asc(j.sortOrder),
          (j) => OrderingTerm.asc(j.id),
        ]))
      .get();

  Future<Job?> getJob(int id) =>
      (select(jobs)..where((j) => j.id.equals(id))).getSingleOrNull();

  Future<int> insertJob(JobsCompanion entry) async {
    final id = await into(jobs).insert(entry);
    await _markAutoBackupDirty();
    return id;
  }

  Future<bool> updateJob(JobsCompanion entry) async {
    final ok = await update(jobs).replace(entry);
    await _markAutoBackupDirty();
    return ok;
  }

  Future<int> deleteJob(int id) async {
    final n = await (delete(jobs)..where((j) => j.id.equals(id))).go();
    await _markAutoBackupDirty();
    return n;
  }

  // Don't mark dirty for last-run updates — those fire on every run and would
  // defeat the point of the flag.
  Future<void> updateLastRun(int jobId, DateTime at, String status) =>
      (update(jobs)..where((j) => j.id.equals(jobId))).write(
        JobsCompanion(
          lastRunAt: Value(at),
          lastRunStatus: Value(status),
        ),
      );

  Future<void> reorder(int oldIndex, int newIndex) async {
    await transaction(() async {
      final all = await (select(jobs)
            ..orderBy([
              (j) => OrderingTerm.asc(j.sortOrder),
              (j) => OrderingTerm.asc(j.id),
            ]))
          .get();
      final list = [...all];
      final moved = list.removeAt(oldIndex);
      final insertAt = newIndex > oldIndex ? newIndex - 1 : newIndex;
      list.insert(insertAt, moved);
      for (var i = 0; i < list.length; i++) {
        await (update(jobs)..where((j) => j.id.equals(list[i].id)))
            .write(JobsCompanion(sortOrder: Value(i)));
      }
    });
    await _markAutoBackupDirty();
  }

  Future<void> _markAutoBackupDirty() =>
      (update(globalSettings)..where((s) => s.id.equals(1))).write(
        const GlobalSettingsCompanion(autoBackupDirty: Value(true)),
      );
}
