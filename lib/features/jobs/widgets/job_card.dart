import 'package:flutter/material.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/tables/jobs_table.dart';

class JobCard extends StatelessWidget {
  final Job job;
  final VoidCallback onTap;

  const JobCard({super.key, required this.job, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final accentColor = _accentColor() ?? (job.isEnabled ? cs.primary : cs.outline);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left status accent strip
              Container(width: 4, color: accentColor),
              // Job type icon in a rounded container
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 14, 10, 14),
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: job.isEnabled
                        ? cs.primaryContainer
                        : cs.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    job.jobType == JobType.folderBackup
                        ? Icons.folder_rounded
                        : Icons.description_rounded,
                    color: job.isEnabled
                        ? cs.onPrimaryContainer
                        : cs.onSurfaceVariant,
                    size: 22,
                  ),
                ),
              ),
              // Main content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        job.name,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: job.isEnabled
                              ? null
                              : cs.onSurface.withValues(alpha: 0.45),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Text(
                            job.jobType == JobType.folderBackup
                                ? 'Folder'
                                : 'Living file',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: cs.onSurface.withValues(alpha: 0.45),
                              fontSize: 11,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              '·',
                              style: TextStyle(
                                color: cs.onSurface.withValues(alpha: 0.3),
                                fontSize: 11,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.schedule_rounded,
                            size: 11,
                            color: cs.onSurface.withValues(alpha: 0.4),
                          ),
                          const SizedBox(width: 3),
                          Flexible(
                            child: Text(
                              _lastRunText(),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: cs.onSurface.withValues(alpha: 0.45),
                                fontSize: 11,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Trailing: status chip / disabled badge
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 14, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _statusChip(),
                    if (!job.isEnabled) ...[
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                          color: cs.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Off',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: 10,
                            color: cs.onSurface.withValues(alpha: 0.45),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _lastRunText() {
    final last = job.lastRunAt;
    if (last == null) return 'Never run';
    final diff = DateTime.now().difference(last);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  Color? _accentColor() => switch (job.lastRunStatus) {
        'success' => Colors.green,
        'partial' => Colors.orange,
        'failed' => Colors.red,
        'running' => Colors.blue,
        _ => null,
      };

  Widget _statusChip() {
    final status = job.lastRunStatus;
    if (status == null) return const SizedBox.shrink();
    final (color, label) = switch (status) {
      'success' => (Colors.green, 'OK'),
      'partial' => (Colors.orange, 'Partial'),
      'failed' => (Colors.red, 'Failed'),
      'running' => (Colors.blue, 'Running'),
      _ => (Colors.grey, status),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
