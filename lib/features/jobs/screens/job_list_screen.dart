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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Backup of Record'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.go('/settings'),
          ),
        ],
      ),
      body: jobs.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (jobList) {
          if (jobList.isEmpty) {
            return const Center(
              child: Text('No backup jobs yet.\nTap + to add one.'),
            );
          }
          return ListView.builder(
            itemCount: jobList.length,
            itemBuilder: (context, i) => JobCard(
              job: jobList[i],
              onTap: () => context.go('/jobs/${jobList[i].id}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/jobs/new'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
