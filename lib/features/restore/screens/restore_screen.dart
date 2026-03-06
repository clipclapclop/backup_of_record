import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestoreScreen extends ConsumerWidget {
  const RestoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: browse NAS via WebDAV PROPFIND, select file/version, download to phone
    return Scaffold(
      appBar: AppBar(title: const Text('Restore')),
      body: const Center(child: Text('Restore browser — coming soon')),
    );
  }
}
