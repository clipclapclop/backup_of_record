import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JobCreateScreen extends ConsumerWidget {
  const JobCreateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: form to create a new backup job (type, source, destination, schedule, etc.)
    return Scaffold(
      appBar: AppBar(title: const Text('New Backup Job')),
      body: const Center(child: Text('Job creation form — coming soon')),
    );
  }
}
