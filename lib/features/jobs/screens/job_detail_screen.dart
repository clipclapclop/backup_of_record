import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        const SnackBar(
            content: Text('Dry run queued — check run history shortly')),
      );
    }
  }

  void _rebaseline() => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Re-baseline — not yet implemented')));

  void _copyToClipboard(String value, String label) {
    Clipboard.setData(ClipboardData(text: value));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label copied to clipboard'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final job = widget.job;
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(job.name),
        actions: [
          Tooltip(
            message: 'Delete this job and all its history',
            child: IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: _delete,
            ),
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
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: cs.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          job.jobType == JobType.folderBackup
                              ? Icons.folder_rounded
                              : Icons.description_rounded,
                          color: cs.onPrimaryContainer,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        job.jobType == JobType.folderBackup
                            ? 'Folder Backup'
                            : 'Living File',
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      Tooltip(
                        message: job.isEnabled
                            ? 'Disable automatic scheduling for this job'
                            : 'Enable automatic scheduling for this job',
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              job.isEnabled ? 'Enabled' : 'Disabled',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: job.isEnabled
                                    ? cs.primary
                                    : cs.onSurface.withValues(alpha: 0.5),
                              ),
                            ),
                            Switch(
                              value: job.isEnabled,
                              onChanged: (_) => _toggleEnabled(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  _pathRow(
                    context,
                    icon: Icons.phone_android_rounded,
                    label: 'Source',
                    value: job.sourcePath,
                    onLongPress: () =>
                        _copyToClipboard(job.sourcePath, 'Source path'),
                  ),
                  const SizedBox(height: 8),
                  _pathRow(
                    context,
                    icon: Icons.dns_rounded,
                    label: 'NAS destination',
                    value: job.destinationNasPath,
                    onLongPress: () => _copyToClipboard(
                        job.destinationNasPath, 'Destination path'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // ── Config card ───────────────────────────────────────────────
          Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle(context, 'Configuration'),
                  _configRow(context, Icons.schedule_rounded, 'Schedule',
                      _scheduleLabel(job)),
                  _configRow(context, Icons.filter_list_rounded, 'Strategy',
                      _strategyLabel(job.backupStrategy)),
                  _configRow(context, Icons.compare_arrows_rounded,
                      'Comparison', _comparisonLabel(job.comparisonMethod)),
                  _configRow(context, Icons.compress_rounded, 'Compression',
                      _compressionLabel(job.compressionType)),
                  if (job.jobType == JobType.folderBackup &&
                      job.changePolicy != null)
                    _configRow(
                        context,
                        Icons.change_circle_outlined,
                        'Change policy',
                        _changePolicyLabel(job.changePolicy!)),
                  if (job.jobType == JobType.livingFile) ...[
                    if (job.retentionCount != null)
                      _configRow(
                          context,
                          Icons.layers_rounded,
                          'Keep versions',
                          '${job.retentionCount} max'),
                    if (job.retentionDays != null)
                      _configRow(
                          context,
                          Icons.timer_outlined,
                          'Keep for',
                          '${job.retentionDays} days'),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // ── Actions ───────────────────────────────────────────────────
          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Expanded(
                    child: Tooltip(
                      message: 'Queue this job to run immediately',
                      child: FilledButton.icon(
                        onPressed: _runNow,
                        icon: const Icon(Icons.play_arrow_rounded),
                        label: const Text('Run now'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Tooltip(
                      message:
                          'Simulate a run without uploading anything — results appear in history',
                      child: OutlinedButton.icon(
                        onPressed: _dryRun,
                        icon: const Icon(Icons.visibility_outlined),
                        label: const Text('Dry run'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Tooltip(
                    message:
                        'Reset the last-run baseline so the next run treats all files as new',
                    child: OutlinedButton.icon(
                      onPressed: _rebaseline,
                      icon: const Icon(Icons.restart_alt_rounded),
                      label: const Text('Re-baseline'),
                    ),
                  ),
                ],
              ),
            ),
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
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Column(
                    children: [
                      Icon(
                        Icons.history_rounded,
                        size: 48,
                        color: cs.onSurface.withValues(alpha: 0.18),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'No runs yet',
                        style: theme.textTheme.bodyMedium?.copyWith(
                            color: cs.onSurface.withValues(alpha: 0.5)),
                      ),
                    ],
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

  Widget _pathRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onLongPress,
  }) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Tooltip(
      message: 'Long-press to copy',
      child: InkWell(
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon,
                  size: 14,
                  color: cs.onSurface.withValues(alpha: 0.45)),
              const SizedBox(width: 8),
              SizedBox(
                width: 108,
                child: Text(
                  label,
                  style: theme.textTheme.bodySmall?.copyWith(
                      color: cs.onSurface.withValues(alpha: 0.55)),
                ),
              ),
              Expanded(
                child: Text(
                  value,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _configRow(BuildContext context, IconData icon, String label,
      String value) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 14, color: cs.primary.withValues(alpha: 0.7)),
          const SizedBox(width: 8),
          SizedBox(
            width: 112,
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                  color: cs.onSurface.withValues(alpha: 0.6)),
            ),
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
    final duration = run.completedAt?.difference(run.startedAt);
    final (statusColor, _) = _statusStyle(run.status);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: (run.filesUploaded > 0 || run.filesFailed > 0)
            ? () => context.push('/jobs/$jobId/runs/${run.id}/log')
            : null,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Status color strip
              Container(width: 3, color: statusColor),
              Expanded(
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
                          if (run.filesUploaded > 0 || run.filesFailed > 0)
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Icon(
                                Icons.chevron_right_rounded,
                                size: 16,
                                color: theme.colorScheme.onSurface
                                    .withValues(alpha: 0.4),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 12,
                        children: [
                          _statItem(context, Icons.search_rounded,
                              run.filesScanned, 'scanned'),
                          _statItem(context, Icons.upload_rounded,
                              run.filesUploaded, 'uploaded'),
                          _statItem(context, Icons.skip_next_rounded,
                              run.filesSkipped, 'skipped'),
                          if (run.filesFailed > 0)
                            _statItem(
                                context,
                                Icons.error_outline_rounded,
                                run.filesFailed,
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

  (Color, String) _statusStyle(RunStatus status) => switch (status) {
        RunStatus.running => (Colors.blue, 'Running'),
        RunStatus.success => (Colors.green, 'Success'),
        RunStatus.partial => (Colors.orange, 'Partial'),
        RunStatus.failed => (Colors.red, 'Failed'),
        RunStatus.cancelled => (Colors.grey, 'Cancelled'),
        RunStatus.dryRun => (Colors.purple, 'Dry Run'),
      };

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
    final (color, label) = switch (status) {
      RunStatus.running => (Colors.blue, 'Running'),
      RunStatus.success => (Colors.green, 'Success'),
      RunStatus.partial => (Colors.orange, 'Partial'),
      RunStatus.failed => (Colors.red, 'Failed'),
      RunStatus.cancelled => (Colors.grey, 'Cancelled'),
      RunStatus.dryRun => (Colors.purple, 'Dry Run'),
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
