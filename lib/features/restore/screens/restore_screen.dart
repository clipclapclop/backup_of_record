import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/providers/settings_provider.dart';
import '../../../core/services/secure_storage_service.dart';
import '../../../core/services/webdav_service.dart';

// ── Providers ─────────────────────────────────────────────────────────────────

final _listProvider =
    FutureProvider.family<List<WebDavEntry>, String>((ref, path) async {
  final settings = await ref.watch(settingsProvider.future);
  if (settings == null) throw Exception('NAS not configured');
  final password = await SecureStorageService().getNasPassword() ?? '';
  final webdav = WebDavService(
    host: settings.nasHost,
    port: settings.nasPort,
    useHttps: settings.useHttps,
    username: settings.nasUsername,
    password: password,
  );
  try {
    final entries = await webdav.listDirectory(path);
    entries.sort((a, b) {
      if (a.isDirectory != b.isDirectory) return a.isDirectory ? -1 : 1;
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
    return entries;
  } finally {
    webdav.dispose();
  }
});

// ── RestoreScreen ─────────────────────────────────────────────────────────────

class RestoreScreen extends ConsumerStatefulWidget {
  const RestoreScreen({super.key});

  @override
  ConsumerState<RestoreScreen> createState() => _RestoreScreenState();
}

class _RestoreScreenState extends ConsumerState<RestoreScreen> {
  // Navigation stack — starts at root
  final List<String> _pathStack = ['/'];

  String get _currentPath => _pathStack.last;

  void _push(String path) => setState(() => _pathStack.add(path));

  void _pop() {
    if (_pathStack.length > 1) setState(() => _pathStack.removeLast());
  }

  // ── Download ───────────────────────────────────────────────────────────────

  Future<void> _download(WebDavEntry entry) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Download file?'),
        content: Text(
          'Download "${entry.name}" to your Downloads folder?',
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Download')),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    final settings = ref.read(settingsProvider).valueOrNull;
    if (settings == null) return;

    final password = await SecureStorageService().getNasPassword() ?? '';
    final webdav = WebDavService(
      host: settings.nasHost,
      port: settings.nasPort,
      useHttps: settings.useHttps,
      username: settings.nasUsername,
      password: password,
    );

    if (!mounted) return;

    int received = 0;
    int total = entry.contentLength;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => _DownloadDialog(
        filename: entry.name,
        getProgress: () => total > 0 ? received / total : null,
      ),
    );

    try {
      final dir = await getExternalStorageDirectory() ??
          await getApplicationDocumentsDirectory();
      final localPath = '${dir.path}/${entry.name}';

      await webdav.downloadFile(
        entry.path,
        localPath,
        onProgress: (r, t) {
          received = r;
          total = t;
        },
      );

      if (mounted) {
        Navigator.of(context).pop(); // close progress dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Saved to ${dir.path}/${entry.name}'),
            duration: const Duration(seconds: 5),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Download failed: $e')),
        );
      }
    } finally {
      webdav.dispose();
    }
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final listAsync = ref.watch(_listProvider(_currentPath));
    final theme = Theme.of(context);

    return PopScope(
      canPop: _pathStack.length <= 1,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _pop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Restore'),
          leading: _pathStack.length > 1
              ? Tooltip(
                  message: 'Go up to parent folder',
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_rounded),
                    onPressed: _pop,
                  ),
                )
              : null,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: _Breadcrumb(
              stack: _pathStack,
              onTap: (i) =>
                  setState(() => _pathStack.removeRange(i + 1, _pathStack.length)),
            ),
          ),
        ),
        body: listAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.cloud_off,
                      size: 48,
                      color:
                          theme.colorScheme.onSurface.withValues(alpha: 0.4)),
                  const SizedBox(height: 12),
                  Text(e.toString(),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () => ref.invalidate(_listProvider(_currentPath)),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
          data: (entries) {
            if (entries.isEmpty) {
              return Center(
                child: Text('Empty folder',
                    style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface
                            .withValues(alpha: 0.5))),
              );
            }
            return ListView.separated(
              itemCount: entries.length,
              separatorBuilder: (_, _) =>
                  const Divider(height: 1, indent: 56),
              itemBuilder: (_, i) {
                final e = entries[i];
                return ListTile(
                  leading: Icon(
                    e.isDirectory ? Icons.folder : Icons.insert_drive_file,
                    color: e.isDirectory
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                  title: Text(e.name, overflow: TextOverflow.ellipsis),
                  subtitle: e.isDirectory
                      ? null
                      : Text(
                          _formatBytes(e.contentLength),
                          style: theme.textTheme.bodySmall,
                        ),
                  trailing: e.isDirectory
                      ? const Icon(Icons.chevron_right)
                      : IconButton(
                          icon: const Icon(Icons.download_outlined),
                          tooltip: 'Download',
                          onPressed: () => _download(e),
                        ),
                  onTap: e.isDirectory
                      ? () => _push(e.path.endsWith('/')
                          ? e.path
                          : '${e.path}/')
                      : () => _download(e),
                );
              },
            );
          },
        ),
      ),
    );
  }

  String _formatBytes(int b) {
    if (b < 1024) return '$b B';
    if (b < 1048576) return '${(b / 1024).toStringAsFixed(1)} KB';
    if (b < 1073741824) return '${(b / 1048576).toStringAsFixed(1)} MB';
    return '${(b / 1073741824).toStringAsFixed(2)} GB';
  }
}

// ── Breadcrumb ────────────────────────────────────────────────────────────────

class _Breadcrumb extends StatelessWidget {
  final List<String> stack;
  final void Function(int index) onTap;
  const _Breadcrumb({required this.stack, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        itemCount: stack.length,
        separatorBuilder: (_, _) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Icon(Icons.chevron_right_rounded,
              size: 16,
              color: cs.onSurface.withValues(alpha: 0.35)),
        ),
        itemBuilder: (_, i) {
          final label = i == 0
              ? 'NAS'
              : stack[i].split('/').where((s) => s.isNotEmpty).last;
          final isLast = i == stack.length - 1;
          return Tooltip(
            message: isLast ? 'Current folder' : 'Navigate to $label',
            child: GestureDetector(
              onTap: isLast ? null : () => onTap(i),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: isLast
                    ? BoxDecoration(
                        color: cs.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      )
                    : null,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      i == 0 ? Icons.storage_rounded : Icons.folder_rounded,
                      size: 13,
                      color: isLast
                          ? cs.onPrimaryContainer
                          : cs.onSurface.withValues(alpha: 0.55),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      label,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isLast
                            ? cs.onPrimaryContainer
                            : cs.onSurface.withValues(alpha: 0.6),
                        fontWeight:
                            isLast ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Download progress dialog ───────────────────────────────────────────────────

class _DownloadDialog extends StatefulWidget {
  final String filename;
  final double? Function() getProgress;
  const _DownloadDialog({required this.filename, required this.getProgress});

  @override
  State<_DownloadDialog> createState() => _DownloadDialogState();
}

class _DownloadDialogState extends State<_DownloadDialog> {
  @override
  Widget build(BuildContext context) {
    final progress = widget.getProgress();
    return AlertDialog(
      title: const Text('Downloading…'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.filename,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 12),
          LinearProgressIndicator(value: progress),
        ],
      ),
    );
  }
}
