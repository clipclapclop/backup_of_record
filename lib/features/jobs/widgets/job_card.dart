import 'package:flutter/material.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/tables/jobs_table.dart';

class JobCard extends StatelessWidget {
  final Job job;
  final VoidCallback onTap;

  const JobCard({super.key, required this.job, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          job.jobType == JobType.folderBackup ? Icons.folder : Icons.description,
        ),
        title: Text(job.name),
        subtitle: Text(_subtitle()),
        trailing: _statusChip(),
      ),
    );
  }

  String _subtitle() {
    final last = job.lastRunAt;
    if (last == null) return 'Never run';
    final diff = DateTime.now().difference(last);
    if (diff.inMinutes < 60) return 'Last run ${diff.inMinutes}m ago';
    if (diff.inHours < 24) return 'Last run ${diff.inHours}h ago';
    return 'Last run ${diff.inDays}d ago';
  }

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
    return Chip(
      label: Text(label, style: const TextStyle(fontSize: 11)),
      backgroundColor: color.withAlpha(40),
      side: BorderSide(color: color, width: 1),
      padding: EdgeInsets.zero,
    );
  }
}
