import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/tables/job_runs_table.dart';
import '../../../core/providers/database_provider.dart';
import '../../../core/providers/jobs_provider.dart';
import '../../../core/services/foreground_runner.dart';
import '../../../core/services/scheduling_service.dart';

class QueueScreen extends ConsumerWidget {
  const QueueScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeAsync = ref.watch(activeRunsProvider);
    final jobsAsync = ref.watch(jobsProvider);
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Queue'),
      ),
      body: activeAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (runs) {
          if (runs.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.playlist_play_rounded,
                    size: 72,
                    color: cs.primary.withValues(alpha: 0.18),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No active jobs',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: cs.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Tap Run Now or Dry Run on any job to queue it.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: cs.onSurface.withValues(alpha: 0.4),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          final jobMap = {
            for (final j in jobsAsync.valueOrNull ?? <Job>[]) j.id: j,
          };

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: runs.length,
            itemBuilder: (context, i) => _QueueCard(
              run: runs[i],
              job: jobMap[runs[i].jobId],
            ),
          );
        },
      ),
    );
  }
}

// ── Individual queue card ─────────────────────────────────────────────────────

class _QueueCard extends ConsumerWidget {
  final JobRun run;
  final Job? job;

  const _QueueCard({required this.run, required this.job});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isQueued = run.status == RunStatus.queued;
    final isRunning = run.status == RunStatus.running ||
        run.status == RunStatus.dryRun;

    final (statusColor, statusLabel) = switch (run.status) {
      RunStatus.queued => (Colors.blueGrey, 'Queued'),
      RunStatus.running => (Colors.blue, 'Running'),
      RunStatus.dryRun => (Colors.purple, 'Running (dry)'),
      _ => (Colors.grey, run.status.name),
    };

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: job != null
            ? () => context.push('/jobs/${job!.id}')
            : null,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Status colour strip
              Container(width: 4, color: statusColor),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 12, 8, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Top row: job name + type badges ─────────────────
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              job?.name ?? 'Job #${run.jobId}',
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          _Chip(statusLabel, statusColor),
                          if (run.isDryRun) ...[
                            const SizedBox(width: 4),
                            _Chip('Dry run', Colors.purple),
                          ],
                        ],
                      ),
                      const SizedBox(height: 6),

                      // ── Time queued ──────────────────────────────────────
                      Row(
                        children: [
                          Icon(Icons.schedule_rounded,
                              size: 13,
                              color: cs.onSurface.withValues(alpha: 0.45)),
                          const SizedBox(width: 4),
                          Text(
                            isQueued
                                ? 'Queued ${_timeAgo(run.startedAt)}'
                                : 'Started ${_timeAgo(run.startedAt)} · ${DateFormat('HH:mm').format(run.startedAt.toLocal())}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: cs.onSurface.withValues(alpha: 0.55),
                            ),
                          ),
                        ],
                      ),

                      // ── Progress (only when running) ─────────────────────
                      if (isRunning) ...[
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: LinearProgressIndicator(
                            value: null, // indeterminate
                            minHeight: 3,
                            color: statusColor,
                            backgroundColor:
                                statusColor.withValues(alpha: 0.15),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 12,
                          children: [
                            _statText(context, Icons.search_rounded,
                                run.filesScanned, 'scanned'),
                            _statText(context, Icons.upload_rounded,
                                run.filesUploaded, 'uploaded'),
                            _statText(context, Icons.skip_next_rounded,
                                run.filesSkipped, 'skipped'),
                            if (run.filesFailed > 0)
                              _statText(
                                  context,
                                  Icons.error_outline_rounded,
                                  run.filesFailed,
                                  'failed',
                                  color: cs.error),
                            if (run.bytesTransferred > 0)
                              _statText(
                                  context,
                                  Icons.data_usage_rounded,
                                  null,
                                  _formatBytes(run.bytesTransferred)),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              // ── Cancel button ────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: IconButton(
                  tooltip: isQueued ? 'Remove from queue' : 'Cancel run',
                  icon: const Icon(Icons.close_rounded),
                  color: cs.onSurface.withValues(alpha: 0.5),
                  onPressed: () => _cancel(context, ref, isQueued),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _cancel(
      BuildContext context, WidgetRef ref, bool isQueued) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isQueued ? 'Remove from queue?' : 'Cancel run?'),
        content: Text(
          isQueued
              ? 'The job will be removed from the queue before it starts.'
              : 'The in-progress backup will be cancelled. Files already uploaded will remain on the NAS.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Keep'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(ctx).colorScheme.error,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(isQueued ? 'Remove' : 'Cancel'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    final db = ref.read(databaseProvider);
    if (isQueued) {
      // Cancel WorkManager task and mark run as cancelled immediately.
      await SchedulingService.cancelOneOff(run.jobId);
      await db.runsDao.updateRun(JobRunsCompanion(
        id: Value(run.id),
        status: const Value(RunStatus.cancelled),
        completedAt: Value(DateTime.now()),
      ));
    } else {
      // Signal the engine to stop between files.
      // Cancel both the foreground runner (if active) and the DB flag
      // (for WorkManager-driven runs).
      if (ForegroundRunner.isRunning &&
          ForegroundRunner.activeJobId == run.jobId) {
        ForegroundRunner.cancel();
      }
      await db.runsDao.requestCancel(run.id);
    }
  }

  Widget _statText(BuildContext context, IconData icon, int? count,
      String label, {Color? color}) {
    final c = color ??
        Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: c),
        const SizedBox(width: 3),
        Text(
          count != null ? '$count $label' : label,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: c, fontSize: 11),
        ),
      ],
    );
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inSeconds < 60) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    return '${diff.inHours}h ago';
  }

  String _formatBytes(int bytes) {
    if (bytes < 1048576) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1073741824) {
      return '${(bytes / 1048576).toStringAsFixed(1)} MB';
    }
    return '${(bytes / 1073741824).toStringAsFixed(2)} GB';
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final Color color;
  const _Chip(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
