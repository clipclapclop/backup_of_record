import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogScreen extends ConsumerWidget {
  final int jobId;
  final int runId;
  const LogScreen({super.key, required this.jobId, required this.runId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: load FileRunLogs for this run and display per-file outcomes
    return Scaffold(
      appBar: AppBar(title: const Text('Run Log')),
      body: const Center(child: Text('Run log — coming soon')),
    );
  }
}
