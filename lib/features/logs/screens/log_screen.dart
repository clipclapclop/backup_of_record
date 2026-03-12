import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/tables/file_run_logs_table.dart';
import '../../../core/providers/database_provider.dart';
import '../../../core/providers/jobs_provider.dart';

final _logsProvider =
    FutureProvider.family<List<FileRunLog>, int>((ref, runId) async {
  final db = ref.watch(databaseProvider);
  final logs = await db.filesDao.getLogsForRun(runId);
  return logs.reversed.toList();
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
    final theme = Theme.of(context);

    final run = runAsync.valueOrNull
        ?.where((r) => r.id == widget.runId)
        .firstOrNull;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Run Log'),
            if (run != null)
              Text(
                DateFormat('MMM d, y · HH:mm').format(run.startedAt.toLocal()),
                style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7)),
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
      body: logsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (logs) {
          final filtered = _filter == null
              ? logs
              : logs.where((l) => l.action == _filter).toList();

          if (filtered.isEmpty) {
            return Center(
              child: Text(
                _filter == null ? 'No log entries' : 'No entries for this filter',
                style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
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
    );
  }
}

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
      };
}
