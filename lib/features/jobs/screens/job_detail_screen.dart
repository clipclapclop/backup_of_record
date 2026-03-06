import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JobDetailScreen extends ConsumerWidget {
  final int jobId;
  const JobDetailScreen({super.key, required this.jobId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: load job + run history from DB
    return Scaffold(
      appBar: AppBar(title: const Text('Job Detail')),
      body: const Center(child: Text('Job detail — coming soon')),
    );
  }
}
