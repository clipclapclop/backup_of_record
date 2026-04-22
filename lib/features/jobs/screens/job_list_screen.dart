import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/database_provider.dart';
import '../../../core/providers/jobs_provider.dart';
import '../widgets/job_card.dart';

class JobListScreen extends ConsumerStatefulWidget {
  const JobListScreen({super.key});

  @override
  ConsumerState<JobListScreen> createState() => _JobListScreenState();
}

class _JobListScreenState extends ConsumerState<JobListScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // When the app returns to foreground, invalidate the jobs provider so
    // Drift re-reads from SQLite.  Background WorkManager tasks write via
    // their own DB instance, so Drift's in-process stream notifications
    // are never fired for those writes.
    if (state == AppLifecycleState.resumed) {
      ref.invalidate(jobsProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final jobs = ref.watch(jobsProvider);
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.backup_rounded, size: 22, color: cs.primary),
            const SizedBox(width: 8),
            const Text('Backup of Record'),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            tooltip: 'More options',
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              switch (value) {
                case 'queue':
                  context.push('/queue');
                case 'restore':
                  context.go('/restore');
                case 'settings':
                  context.push('/settings');
              }
            },
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: 'queue',
                child: ListTile(
                  leading: Icon(Icons.playlist_play_rounded),
                  title: Text('Queue'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuItem(
                value: 'restore',
                child: ListTile(
                  leading: Icon(Icons.restore_rounded),
                  title: Text('Restore'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuItem(
                value: 'settings',
                child: ListTile(
                  leading: Icon(Icons.settings_outlined),
                  title: Text('Settings'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
      body: jobs.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (jobList) {
          if (jobList.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.backup_rounded,
                    size: 80,
                    color: cs.primary.withValues(alpha: 0.18),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No backup jobs yet',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: cs.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to create your first backup job.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: cs.onSurface.withValues(alpha: 0.45),
                    ),
                  ),
                ],
              ),
            );
          }
          return ReorderableListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 88),
            itemCount: jobList.length,
            buildDefaultDragHandles: false,
            onReorder: (oldIndex, newIndex) {
              ref
                  .read(databaseProvider)
                  .jobsDao
                  .reorder(oldIndex, newIndex);
            },
            itemBuilder: (context, i) {
              final job = jobList[i];
              return JobCard(
                key: ValueKey(job.id),
                job: job,
                onTap: () => context.go('/jobs/${job.id}'),
                onEdit: () => context.push('/jobs/${job.id}/edit'),
                dragHandle: ReorderableDragStartListener(
                  index: i,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 4, 0),
                    child: Icon(
                      Icons.drag_handle,
                      color: cs.onSurface.withValues(alpha: 0.45),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Tooltip(
        message: 'Add backup job',
        child: FloatingActionButton(
          onPressed: () => context.push('/jobs/new'),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
