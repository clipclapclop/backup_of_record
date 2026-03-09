import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/tables/jobs_table.dart';
import '../../../core/database/tables/job_runs_table.dart';
import '../../../core/providers/database_provider.dart';
import '../../../core/providers/jobs_provider.dart';
import '../../../core/services/scheduling_service.dart';

class JobDetailScreen extends ConsumerWidget {
  final int jobId;
  const JobDetailScreen({super.key, required this.jobId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobAsync = ref.watch(jobProvider(jobId));
    final runsAsync = ref.watch(jobRunsProvider(jobId));

    return jobAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (job) {
        if (job == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('Job not found')),
          );
        }
        return _JobDetailView(job: job, runsAsync: runsAsync);
      },
    );
  }
}

class _JobDetailView extends ConsumerStatefulWidget {
  final Job job;
  final AsyncValue<List<JobRun>> runsAsync;
  const _JobDetailView({required this.job, required this.runsAsync});

  @override
  ConsumerState<_JobDetailView> createState() => _JobDetailViewState();
}

class _JobDetailViewState extends ConsumerState<_JobDetailView> {
  Future<void> _toggleEnabled() async {
    final db = ref.read(databaseProvider);
    final updated = widget.job.toCompanion(true).copyWith(
          isEnabled: Value(!widget.job.isEnabled),
        );
    await db.jobsDao.updateJob(updated);
    final job = await db.jobsDao.getJob(widget.job.id);
    if (job != null) await SchedulingService.scheduleJob(job);
  }

  Future<void> _delete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete job?'),
        content: Text(
            'Delete "${widget.job.name}"? Run history will also be removed.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(
                backgroundColor: Theme.of(ctx).colorScheme.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      await SchedulingService.cancelJob(widget.job.id);
      final db = ref.read(databaseProvider);
      await db.jobsDao.deleteJob(widget.job.id);
      if (mounted) context.go('/');
    }
  }

  Future<void> _runNow() async {
    await SchedulingService.runNow(widget.job.id);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Job queued — will run shortly')),
      );
    }
  }

  Future<void> _dryRun() async {
    await SchedulingService.dryRun(widget.job.id);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dry run queued — check run history shortly')),
      );
    }
  }

  void _rebaseline() => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Re-baseline — not yet implemented')));

  @override
  Widget build(BuildContext context) {
    final job = widget.job;
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(job.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Delete job',
            onPressed: _delete,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Header card ───────────────────────────────────────────────
          Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        job.jobType == JobType.folderBackup
                            ? Icons.folder
                            : Icons.description,
                        color: cs.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        job.jobType == JobType.folderBackup
                            ? 'Folder Backup'
                            : 'Living File',
                        style: theme.textTheme.titleMedium,
                      ),
                      const Spacer(),
                      Switch(
                        value: job.isEnabled,
                        onChanged: (_) => _toggleEnabled(),
                      ),
                      Text(
                        job.isEnabled ? 'Enabled' : 'Disabled',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  _labelRow(context, 'Source', job.sourcePath),
                  const SizedBox(height: 4),
                  _labelRow(context, 'Destination (NAS)', job.destinationNasPath),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // ── Config card ───────────────────────────────────────────────
          Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle(context, 'Configuration'),
                  _configRow(context, 'Schedule', _scheduleLabel(job)),
                  _configRow(context, 'Strategy',
                      _strategyLabel(job.backupStrategy)),
                  _configRow(context, 'Comparison',
                      _comparisonLabel(job.comparisonMethod)),
                  _configRow(context, 'Compression',
                      _compressionLabel(job.compressionType)),
                  if (job.jobType == JobType.folderBackup &&
                      job.changePolicy != null)
                    _configRow(context, 'Change policy',
                        _changePolicyLabel(job.changePolicy!)),
                  if (job.jobType == JobType.livingFile) ...[
                    if (job.retentionCount != null)
                      _configRow(context, 'Keep versions',
                          '${job.retentionCount} max'),
                    if (job.retentionDays != null)
                      _configRow(
                          context, 'Keep for', '${job.retentionDays} days'),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // ── Actions ───────────────────────────────────────────────────
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: _runNow,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Run now'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _dryRun,
                  icon: const Icon(Icons.visibility),
                  label: const Text('Dry run'),
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                onPressed: _rebaseline,
                icon: const Icon(Icons.refresh),
                label: const Text('Re-baseline'),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // ── Run history ───────────────────────────────────────────────
          _sectionTitle(context, 'Run History'),
          widget.runsAsync.when(
            loading: () =>
                const Center(child: CircularProgressIndicator()),
            error: (e, _) => Text('Error loading runs: $e'),
            data: (runs) {
              if (runs.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: Text(
                      'No runs yet',
                      style: theme.textTheme.bodyMedium?.copyWith(
                          color: cs.onSurface.withValues(alpha: 0.5)),
                    ),
                  ),
                );
              }
              return Column(
                children: runs
                    .map((r) => _RunTile(run: r, jobId: widget.job.id))
                    .toList(),
              );
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _labelRow(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(label,
              style: theme.textTheme.bodySmall?.copyWith(
                  color:
                      theme.colorScheme.onSurface.withValues(alpha: 0.6))),
        ),
        Expanded(
          child: Text(value,
              style: theme.textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
              maxLines: 2),
        ),
      ],
    );
  }

  Widget _configRow(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: Text(label,
                style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface
                        .withValues(alpha: 0.6))),
          ),
          Expanded(
            child: Text(value, style: theme.textTheme.bodySmall),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
      );

  String _scheduleLabel(Job job) => switch (job.scheduleType) {
        ScheduleType.manual => 'Manual only',
        ScheduleType.daily => 'Daily at ${job.scheduleConfig}',
        ScheduleType.weekly => 'Weekly',
        ScheduleType.onChange =>
          'On change (every ${job.scheduleConfig} min)',
      };

  String _strategyLabel(BackupStrategy s) => switch (s) {
        BackupStrategy.incremental => 'Incremental',
        BackupStrategy.fromDate => 'From date',
        BackupStrategy.full => 'Full',
      };

  String _comparisonLabel(ComparisonMethod m) => switch (m) {
        ComparisonMethod.metadata => 'Metadata',
        ComparisonMethod.hash => 'Hash (MD5)',
        ComparisonMethod.hashThenMetadata =>
          'Hash first run, metadata after',
      };

  String _compressionLabel(CompressionType t) => switch (t) {
        CompressionType.none => 'None',
        CompressionType.gzip => 'Gzip',
        CompressionType.zip => 'Zip',
      };

  String _changePolicyLabel(ChangePolicy p) => switch (p) {
        ChangePolicy.archiveOnly => 'Archive only',
        ChangePolicy.overwrite => 'Overwrite',
        ChangePolicy.versionOnChange => 'Version on change',
      };
}

// ── Run history tile ──────────────────────────────────────────────────────────

class _RunTile extends StatelessWidget {
  final JobRun run;
  final int jobId;
  const _RunTile({required this.run, required this.jobId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final duration =
        run.completedAt?.difference(run.startedAt);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: (run.filesUploaded > 0 || run.filesFailed > 0)
            ? () => context.push('/jobs/$jobId/runs/${run.id}/log')
            : null,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _StatusChip(run.status),
                  const Spacer(),
                  Text(
                    DateFormat('MMM d, y · HH:mm')
                        .format(run.startedAt.toLocal()),
                    style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface
                            .withValues(alpha: 0.6)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                children: [
                  _statItem(context, Icons.search, run.filesScanned,
                      'scanned'),
                  _statItem(context, Icons.upload, run.filesUploaded,
                      'uploaded'),
                  _statItem(context, Icons.skip_next, run.filesSkipped,
                      'skipped'),
                  if (run.filesFailed > 0)
                    _statItem(context, Icons.error_outline, run.filesFailed,
                        'failed',
                        color: theme.colorScheme.error),
                ],
              ),
              if (run.bytesTransferred > 0 || duration != null) ...[
                const SizedBox(height: 4),
                Text(
                  [
                    if (run.bytesTransferred > 0)
                      _formatBytes(run.bytesTransferred),
                    if (duration != null) _formatDuration(duration),
                  ].join(' · '),
                  style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface
                          .withValues(alpha: 0.6)),
                ),
              ],
              if (run.errorSummary != null) ...[
                const SizedBox(height: 6),
                Text(
                  run.errorSummary!,
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: theme.colorScheme.error),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _statItem(BuildContext context, IconData icon, int count,
      String label, {Color? color}) {
    final theme = Theme.of(context);
    final c =
        color ?? theme.colorScheme.onSurface.withValues(alpha: 0.65);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: c),
        const SizedBox(width: 2),
        Text('$count $label',
            style: theme.textTheme.bodySmall?.copyWith(color: c)),
      ],
    );
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1048576) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1073741824) {
      return '${(bytes / 1048576).toStringAsFixed(1)} MB';
    }
    return '${(bytes / 1073741824).toStringAsFixed(2)} GB';
  }

  String _formatDuration(Duration d) {
    if (d.inSeconds < 60) return '${d.inSeconds}s';
    if (d.inMinutes < 60) return '${d.inMinutes}m ${d.inSeconds % 60}s';
    return '${d.inHours}h ${d.inMinutes % 60}m';
  }
}

class _StatusChip extends StatelessWidget {
  final RunStatus status;
  const _StatusChip(this.status);

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      RunStatus.running => ('Running', Colors.blue),
      RunStatus.success => ('Success', Colors.green),
      RunStatus.partial => ('Partial', Colors.orange),
      RunStatus.failed => ('Failed', Colors.red),
      RunStatus.cancelled => ('Cancelled', Colors.grey),
      RunStatus.dryRun => ('Dry Run', Colors.purple),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
