import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'features/jobs/screens/job_list_screen.dart';
import 'features/jobs/screens/job_detail_screen.dart';
import 'features/jobs/screens/job_create_screen.dart';
import 'features/settings/screens/settings_screen.dart';
import 'features/logs/screens/log_screen.dart';
import 'features/restore/screens/restore_screen.dart';

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (_, _) => const JobListScreen(),
    ),
    GoRoute(
      path: '/jobs/new',
      builder: (_, _) => const JobCreateScreen(),
    ),
    GoRoute(
      path: '/jobs/:id',
      builder: (_, state) => JobDetailScreen(
        jobId: int.parse(state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/jobs/:jobId/runs/:runId/log',
      builder: (_, state) => LogScreen(
        jobId: int.parse(state.pathParameters['jobId']!),
        runId: int.parse(state.pathParameters['runId']!),
      ),
    ),
    GoRoute(
      path: '/settings',
      builder: (_, _) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/restore',
      builder: (_, _) => const RestoreScreen(),
    ),
  ],
);

class BackupApp extends StatelessWidget {
  const BackupApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Backup of Record',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
