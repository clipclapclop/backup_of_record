import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;

import '../../../core/database/app_database.dart';
import '../../../core/database/tables/file_run_logs_table.dart';
import '../../../core/database/tables/job_runs_table.dart';
import '../../../core/providers/database_provider.dart';
import '../../../core/providers/jobs_provider.dart';

// Live stream — auto-updates as files are processed
final _logsProvider =
    StreamProvider.family<List<FileRunLog>, int>((ref, runId) {
  final db = ref.watch(databaseProvider);
  return db.filesDao.watchLogsForRun(runId); // already sorted newest-first
});

final _inProgressProvider =
    StreamProvider.family<List<InProgressUpload>, int>((ref, jobId) {
  final db = ref.watch(databaseProvider);
  return db.filesDao.watchInProgressForJob(jobId);
});

class LogScreen extends ConsumerStatefulWidget {
  final int jobId;
  final int runId;
  const LogScreen({super.key, required this.jobId, required this.runId});

  @override
  ConsumerState<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends ConsumerState<LogScreen> {
  FileAction? _filter;

  @override
  Widget build(BuildContext context) {
    final runAsync = ref.watch(jobRunsProvider(widget.jobId));
    final logsAsync = ref.watch(_logsProvider(widget.runId));
    final inProgressAsync = ref.watch(_inProgressProvider(widget.jobId));
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final run = runAsync.valueOrNull
        ?.where((r) => r.id == widget.runId)
        .firstOrNull;

    final isRunning = run?.status == RunStatus.running;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Run Log'),
                if (isRunning) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Colors.blue.withValues(alpha: 0.5)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 8,
                          height: 8,
                          child: CircularProgressIndicator(
                            strokeWidth: 1.5,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          'LIVE',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
            if (run != null)
              Text(
                DateFormat('MMM d, y · HH:mm').format(run.startedAt.toLocal()),
                style: theme.textTheme.bodySmall?.copyWith(
                    color: cs.onSurface.withValues(alpha: 0.7)),
              ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: _FilterBar(
            current: _filter,
            onChanged: (f) => setState(() => _filter = f),
          ),
        ),
      ),
      body: Column(
        children: [
          // ── Active upload banner ───────────────────────────────────────
          if (isRunning)
            _ActiveUploadBanner(
              inProgressAsync: inProgressAsync,
              logsAsync: logsAsync,
            ),

          // ── Log list ──────────────────────────────────────────────────
          Expanded(
            child: logsAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (logs) {
                final filtered = _filter == null
                    ? logs
                    : logs.where((l) => l.action == _filter).toList();

                if (filtered.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (isRunning) ...[
                          const CircularProgressIndicator(),
                          const SizedBox(height: 16),
                          Text(
                            'Waiting for files to process…',
                            style: theme.textTheme.bodyMedium?.copyWith(
                                color: cs.onSurface.withValues(alpha: 0.5)),
                          ),
                        ] else
                          Text(
                            _filter == null
                                ? 'No log entries'
                                : 'No entries for this filter',
                            style: theme.textTheme.bodyMedium?.copyWith(
                                color:
                                    cs.onSurface.withValues(alpha: 0.5)),
                          ),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: filtered.length,
                  separatorBuilder: (_, _) =>
                      const Divider(height: 1, indent: 16, endIndent: 16),
                  itemBuilder: (_, i) => _LogTile(log: filtered[i]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── Active upload banner ───────────────────────────────────────────────────────

class _ActiveUploadBanner extends StatelessWidget {
  final AsyncValue<List<InProgressUpload>> inProgressAsync;
  final AsyncValue<List<FileRunLog>> logsAsync;

  const _ActiveUploadBanner({
    required this.inProgressAsync,
    required this.logsAsync,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final uploads = inProgressAsync.valueOrNull ?? [];
    final logs = logsAsync.valueOrNull ?? [];

    // Count processed files from the live log
    final uploaded = logs.where((l) => l.action == FileAction.uploaded).length;
    final skipped = logs.where((l) => l.action == FileAction.skipped).length;
    final failed = logs.where((l) => l.action == FileAction.failed).length;
    final locked = logs.where((l) => l.action == FileAction.locked).length;

    return Container(
      width: double.infinity,
      color: Colors.blue.withValues(alpha: 0.06),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current file
          if (uploads.isNotEmpty) ...[
            for (final upload in uploads) ...[
              Row(
                children: [
                  const SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.blue),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      p.basename(upload.localPath),
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: cs.onSurface,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (upload.totalBytes > 0) ...[
                    const SizedBox(width: 8),
                    Text(
                      '${_fmt(upload.bytesUploaded)} / ${_fmt(upload.totalBytes)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                          color: cs.onSurface.withValues(alpha: 0.6)),
                    ),
                  ],
                ],
              ),
              if (upload.totalBytes > 0) ...[
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    value: upload.bytesUploaded / upload.totalBytes,
                    minHeight: 3,
                    backgroundColor: cs.onSurface.withValues(alpha: 0.1),
                    color: Colors.blue,
                  ),
                ),
              ],
            ],
          ] else ...[
            Row(
              children: [
                const SizedBox(
                  width: 14,
                  height: 14,
                  child:
                      CircularProgressIndicator(strokeWidth: 2, color: Colors.blue),
                ),
                const SizedBox(width: 8),
                Text(
                  'Scanning files…',
                  style: theme.textTheme.bodySmall?.copyWith(
                      color: cs.onSurface.withValues(alpha: 0.7)),
                ),
              ],
            ),
          ],

          // Running totals
          if (uploaded + skipped + failed + locked > 0) ...[
            const SizedBox(height: 6),
            Wrap(
              spacing: 12,
              children: [
                if (uploaded > 0)
                  _miniStat(context, Icons.upload_rounded, '$uploaded uploaded',
                      Colors.green),
                if (skipped > 0)
                  _miniStat(context, Icons.skip_next_rounded,
                      '$skipped skipped', Colors.grey),
                if (failed > 0)
                  _miniStat(context, Icons.error_outline_rounded,
                      '$failed failed', cs.error),
                if (locked > 0)
                  _miniStat(context, Icons.lock_outline_rounded,
                      '$locked locked', Colors.orange),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _miniStat(
      BuildContext context, IconData icon, String label, Color color) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: color),
        const SizedBox(width: 3),
        Text(label,
            style: theme.textTheme.bodySmall
                ?.copyWith(color: color, fontSize: 11)),
      ],
    );
  }

  String _fmt(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1048576) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1073741824) return '${(bytes / 1048576).toStringAsFixed(1)} MB';
    return '${(bytes / 1073741824).toStringAsFixed(2)} GB';
  }
}

// ── Filter bar ────────────────────────────────────────────────────────────────

class _FilterBar extends StatelessWidget {
  final FileAction? current;
  final ValueChanged<FileAction?> onChanged;
  const _FilterBar({required this.current, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    const chips = <(FileAction?, String, IconData, String)>[
      (null, 'All', Icons.list_rounded, 'Show all log entries'),
      (FileAction.uploaded, 'Uploaded', Icons.upload_rounded,
          'Files successfully uploaded to NAS'),
      (FileAction.skipped, 'Skipped', Icons.skip_next_rounded,
          'Files skipped because they haven\'t changed'),
      (FileAction.failed, 'Failed', Icons.error_outline_rounded,
          'Files that failed to upload'),
      (FileAction.locked, 'Locked', Icons.lock_outline_rounded,
          'Files skipped because they were open in another app'),
      (FileAction.retentionDeleted, 'Deleted', Icons.delete_outline_rounded,
          'Old versions removed by retention rules'),
      (FileAction.strategyFiltered, 'Filtered', Icons.filter_alt_outlined,
          'Files excluded by backup strategy (fromDate / incremental cutoff, or empty source dir)'),
    ];

    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        children: chips.map((c) {
          final selected = current == c.$1;
          return Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Tooltip(
              message: c.$4,
              child: FilterChip(
                label: Text(c.$2),
                avatar: Icon(c.$3, size: 14),
                selected: selected,
                onSelected: (_) => onChanged(c.$1),
                padding: const EdgeInsets.symmetric(horizontal: 4),
                visualDensity: VisualDensity.compact,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ── Log tile ──────────────────────────────────────────────────────────────────

class _LogTile extends StatelessWidget {
  final FileRunLog log;
  const _LogTile({required this.log});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (icon, color) = _style(log.action, theme);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(width: 3, color: color ?? Colors.transparent),
          Expanded(
            child: ListTile(
              dense: true,
              leading: Icon(icon, color: color, size: 18),
              title: Text(
                log.filePath,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              subtitle: log.errorMessage != null
                  ? Text(
                      log.errorMessage!,
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: theme.colorScheme.error),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  : null,
              trailing: Text(
                DateFormat('HH:mm:ss').format(log.occurredAt.toLocal()),
                style: theme.textTheme.bodySmall?.copyWith(
                    color:
                        theme.colorScheme.onSurface.withValues(alpha: 0.5)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  (IconData, Color?) _style(FileAction action, ThemeData theme) =>
      switch (action) {
        FileAction.uploaded => (Icons.upload_rounded, Colors.green),
        FileAction.skipped => (Icons.skip_next_rounded, Colors.grey),
        FileAction.failed =>
          (Icons.error_outline_rounded, theme.colorScheme.error),
        FileAction.locked => (Icons.lock_outline_rounded, Colors.orange),
        FileAction.retentionDeleted =>
          (Icons.delete_outline_rounded, theme.colorScheme.error),
        FileAction.strategyFiltered =>
          (Icons.filter_alt_outlined, Colors.blueGrey),
      };
}
