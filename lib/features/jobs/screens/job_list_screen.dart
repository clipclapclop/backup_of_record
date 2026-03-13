import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/jobs_provider.dart';
import '../widgets/job_card.dart';

class JobListScreen extends ConsumerWidget {
  const JobListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          Tooltip(
            message: 'Browse & restore files from NAS',
            child: IconButton(
              icon: const Icon(Icons.restore_rounded),
              onPressed: () => context.go('/restore'),
            ),
          ),
          Tooltip(
            message: 'Settings',
            child: IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () => context.push('/settings'),
            ),
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
          return ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 88),
            itemCount: jobList.length,
            itemBuilder: (context, i) => JobCard(
              job: jobList[i],
              onTap: () => context.go('/jobs/${jobList[i].id}'),
            ),
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
