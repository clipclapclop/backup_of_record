import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

/// A dialog that lets the user navigate the filesystem and pick a file or
/// directory using dart:io directly — no cache copies, no SAF content URIs.
///
/// Requires MANAGE_EXTERNAL_STORAGE to be granted.
class FileBrowserDialog extends StatefulWidget {
  /// If true, the user selects a directory. If false, the user selects a file.
  final bool pickDirectory;

  /// Optional starting path. Defaults to /storage/emulated/0.
  final String? initialPath;

  const FileBrowserDialog({
    super.key,
    this.pickDirectory = false,
    this.initialPath,
  });

  /// Shows the dialog and returns the selected path, or null if cancelled.
  static Future<String?> show(
    BuildContext context, {
    bool pickDirectory = false,
    String? initialPath,
  }) {
    return showDialog<String>(
      context: context,
      builder: (_) => FileBrowserDialog(
        pickDirectory: pickDirectory,
        initialPath: initialPath,
      ),
    );
  }

  @override
  State<FileBrowserDialog> createState() => _FileBrowserDialogState();
}

class _FileBrowserDialogState extends State<FileBrowserDialog> {
  late String _currentPath;
  List<FileSystemEntity> _entries = [];
  String? _error;
  bool _loading = true;
  bool _showHidden = false;

  @override
  void initState() {
    super.initState();
    _currentPath = widget.initialPath ?? '/storage/emulated/0';
    _listDir();
  }

  void _listDir() {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final dir = Directory(_currentPath);
      if (!dir.existsSync()) {
        setState(() {
          _error = 'Directory not found';
          _entries = [];
          _loading = false;
        });
        return;
      }

      final raw = dir.listSync(followLinks: false);
      final filtered = _showHidden
          ? raw
          : raw.where((e) => !p.basename(e.path).startsWith('.')).toList();

      // Sort: directories first, then alphabetical
      filtered.sort((a, b) {
        final aIsDir = a is Directory;
        final bIsDir = b is Directory;
        if (aIsDir && !bIsDir) return -1;
        if (!aIsDir && bIsDir) return 1;
        return p
            .basename(a.path)
            .toLowerCase()
            .compareTo(p.basename(b.path).toLowerCase());
      });

      setState(() {
        _entries = filtered;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _entries = [];
        _loading = false;
      });
    }
  }

  void _navigateTo(String path) {
    _currentPath = path;
    _listDir();
  }

  void _goUp() {
    final parent = p.dirname(_currentPath);
    if (parent != _currentPath) {
      _navigateTo(parent);
    }
  }

  void _selectCurrent() {
    Navigator.pop(context, _currentPath);
  }

  void _selectFile(String filePath) {
    Navigator.pop(context, filePath);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isRoot = _currentPath == '/' || _currentPath == '/storage/emulated/0';

    return Dialog.fullscreen(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            tooltip: 'Cancel',
            onPressed: () => Navigator.pop(context),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.pickDirectory ? 'Pick folder' : 'Pick file',
                style: theme.textTheme.titleMedium,
              ),
              Text(
                _currentPath,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: cs.onSurface.withValues(alpha: 0.6),
                  fontFamily: 'monospace',
                  fontSize: 11,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(_showHidden
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined),
              tooltip: _showHidden ? 'Hide hidden files' : 'Show hidden files',
              onPressed: () {
                _showHidden = !_showHidden;
                _listDir();
              },
            ),
            if (widget.pickDirectory)
              TextButton(
                onPressed: _selectCurrent,
                child: const Text('Select this folder'),
              ),
          ],
        ),
        body: Column(
          children: [
            // Up-one-level row
            if (!isRoot)
              ListTile(
                leading: Icon(Icons.arrow_upward_rounded,
                    color: cs.primary, size: 20),
                title: Text('Up to ${p.basename(p.dirname(_currentPath))}/',
                    style: TextStyle(color: cs.primary)),
                dense: true,
                onTap: _goUp,
              ),

            if (_error != null)
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.folder_off_rounded,
                            size: 48,
                            color: cs.error.withValues(alpha: 0.6)),
                        const SizedBox(height: 12),
                        Text(
                          'Cannot read this directory',
                          style: theme.textTheme.titleSmall,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _error!,
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: cs.error),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Make sure "All files access" is granted in\n'
                          'Settings \u2192 Apps \u2192 Backup of Record \u2192 Permissions',
                          style: theme.textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else if (_loading)
              const Expanded(
                  child: Center(child: CircularProgressIndicator()))
            else if (_entries.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    'Empty folder',
                    style: theme.textTheme.bodyMedium?.copyWith(
                        color: cs.onSurface.withValues(alpha: 0.5)),
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _entries.length,
                  itemBuilder: (context, i) {
                    final entry = _entries[i];
                    final name = p.basename(entry.path);
                    final isDir = entry is Directory;

                    return ListTile(
                      leading: Icon(
                        isDir
                            ? Icons.folder_rounded
                            : _fileIcon(name),
                        color: isDir
                            ? cs.primary
                            : cs.onSurface.withValues(alpha: 0.6),
                      ),
                      title: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: !isDir ? _fileSizeText(entry as File) : null,
                      dense: true,
                      onTap: () {
                        if (isDir) {
                          _navigateTo(entry.path);
                        } else if (!widget.pickDirectory) {
                          _selectFile(entry.path);
                        }
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget? _fileSizeText(File file) {
    try {
      final bytes = file.lengthSync();
      return Text(_formatBytes(bytes));
    } catch (_) {
      return null;
    }
  }

  String _formatBytes(int b) {
    if (b < 1024) return '$b B';
    if (b < 1048576) return '${(b / 1024).toStringAsFixed(1)} KB';
    if (b < 1073741824) return '${(b / 1048576).toStringAsFixed(1)} MB';
    return '${(b / 1073741824).toStringAsFixed(2)} GB';
  }

  IconData _fileIcon(String name) {
    final ext = p.extension(name).toLowerCase();
    return switch (ext) {
      '.jpg' || '.jpeg' || '.png' || '.gif' || '.webp' || '.heic' =>
        Icons.image_rounded,
      '.mp4' || '.mov' || '.avi' || '.mkv' => Icons.videocam_rounded,
      '.mp3' || '.aac' || '.wav' || '.flac' || '.ogg' =>
        Icons.audiotrack_rounded,
      '.pdf' => Icons.picture_as_pdf_rounded,
      '.doc' || '.docx' || '.txt' || '.rtf' => Icons.article_rounded,
      '.xls' || '.xlsx' || '.csv' => Icons.table_chart_rounded,
      '.zip' || '.gz' || '.tar' || '.7z' || '.rar' =>
        Icons.folder_zip_rounded,
      '.db' || '.sqlite' => Icons.storage_rounded,
      '.json' || '.xml' || '.yaml' || '.yml' => Icons.code_rounded,
      '.apk' => Icons.android_rounded,
      _ => Icons.insert_drive_file_rounded,
    };
  }
}
