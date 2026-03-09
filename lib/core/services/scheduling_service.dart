import 'package:workmanager/workmanager.dart';

import '../database/app_database.dart';
import '../database/tables/jobs_table.dart';

/// Manages WorkManager task registration for each backup job.
///
/// Each job that has a non-manual schedule gets a periodic WorkManager task.
/// WorkManager timing is approximate — it respects battery optimization and
/// Doze mode, so a "daily at 02:00" task may run within a 1–2 hour window.
class SchedulingService {
  static const _taskName = 'runBackupJob';

  static String _periodicName(int jobId) => 'backup_job_$jobId';
  static String _oneOffName(int jobId) => 'backup_job_${jobId}_now';

  // ── Per-job API ─────────────────────────────────────────────────────────────

  /// Registers (or replaces) the periodic WorkManager task for [job].
  /// If the job is disabled or manual, cancels any existing task instead.
  static Future<void> scheduleJob(Job job) async {
    if (!job.isEnabled || job.scheduleType == ScheduleType.manual) {
      await cancelJob(job.id);
      return;
    }

    final frequency = _frequency(job);
    final delay = _initialDelay(job);

    await Workmanager().registerPeriodicTask(
      _periodicName(job.id),
      _taskName,
      frequency: frequency,
      initialDelay: delay,
      inputData: {'jobId': job.id},
      constraints: Constraints(networkType: NetworkType.connected),
      existingWorkPolicy: ExistingPeriodicWorkPolicy.replace,
      backoffPolicy: BackoffPolicy.linear,
      backoffPolicyDelay: const Duration(minutes: 15),
    );
  }

  /// Cancels the periodic WorkManager task for [jobId].
  static Future<void> cancelJob(int jobId) async {
    await Workmanager().cancelByUniqueName(_periodicName(jobId));
  }

  /// Registers a one-off WorkManager task to run [jobId] as soon as possible.
  static Future<void> runNow(int jobId) async {
    await Workmanager().registerOneOffTask(
      _oneOffName(jobId),
      _taskName,
      inputData: {'jobId': jobId},
      constraints: Constraints(networkType: NetworkType.connected),
      existingWorkPolicy: ExistingWorkPolicy.replace,
    );
  }

  /// Registers a one-off dry-run task for [jobId].
  static Future<void> dryRun(int jobId) async {
    await Workmanager().registerOneOffTask(
      '${_oneOffName(jobId)}_dry',
      _taskName,
      inputData: {'jobId': jobId, 'dryRun': true},
      constraints: Constraints(networkType: NetworkType.connected),
      existingWorkPolicy: ExistingWorkPolicy.replace,
    );
  }

  // ── Startup sync ─────────────────────────────────────────────────────────────

  /// Re-registers all enabled, non-manual jobs on app startup.
  /// Called from [main] after WorkManager is initialised.
  static Future<void> syncAllJobs(AppDatabase db) async {
    final jobs = await db.jobsDao.getAllJobs();
    for (final job in jobs) {
      await scheduleJob(job);
    }
  }

  // ── Helpers ──────────────────────────────────────────────────────────────────

  static Duration _frequency(Job job) {
    switch (job.scheduleType) {
      case ScheduleType.daily:
        return const Duration(hours: 24);
      case ScheduleType.weekly:
        return const Duration(days: 7);
      case ScheduleType.onChange:
        final minutes =
            int.tryParse(job.scheduleConfig ?? '') ?? 60;
        // WorkManager minimum period is 15 minutes
        return Duration(minutes: minutes.clamp(15, 60 * 24));
      case ScheduleType.manual:
        return const Duration(hours: 24); // fallback; task won't be registered
    }
  }

  /// Calculates the delay until the first run, aligning daily tasks to the
  /// user's chosen time. Weekly and onChange tasks start immediately.
  static Duration _initialDelay(Job job) {
    if (job.scheduleType != ScheduleType.daily) return Duration.zero;

    final config = job.scheduleConfig ?? '02:00';
    final parts = config.split(':');
    if (parts.length < 2) return Duration.zero;

    final hour = int.tryParse(parts[0]) ?? 2;
    final minute = int.tryParse(parts[1]) ?? 0;

    final now = DateTime.now();
    var target = DateTime(now.year, now.month, now.day, hour, minute);
    if (!target.isAfter(now)) target = target.add(const Duration(days: 1));

    return target.difference(now);
  }
}
