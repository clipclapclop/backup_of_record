import 'package:drift/drift.dart' show Value;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/tables/jobs_table.dart';
import '../../../core/providers/database_provider.dart';
import '../../../core/providers/settings_provider.dart';
import '../../../core/services/export_import_service.dart';
import '../../../core/services/secure_storage_service.dart';
import '../../../core/services/webdav_service.dart';

// Notification flag bit positions
const kNotifyJobFailed = 0x01;
const kNotifyFileLocked = 0x02;
const kNotifyPartialFailure = 0x04;
const kNotifySuccess = 0x08;
const kNotifyRetentionCleanup = 0x10;
const kNotifyLowSpace = 0x20;

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _hostController = TextEditingController();
  final _portController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _spaceThresholdController = TextEditingController();

  final _storage = SecureStorageService();

  bool _useHttps = true;
  bool _showPassword = false;
  int _notificationFlags = 0xFF;
  ComparisonMethod _defaultComparison = ComparisonMethod.metadata;
  CompressionType _defaultCompression = CompressionType.none;

  bool _loading = true;
  bool _saving = false;
  bool? _connectionResult; // null = not tested, true = ok, false = failed
  bool _testing = false;

  String? _backupExportPath;
  bool _exporting = false;
  bool _importing = false;
  final _exportImportService = ExportImportService();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final db = ref.read(databaseProvider);
    final settings = await db.settingsDao.getSettings();
    final password = await _storage.getNasPassword();

    if (mounted) {
      setState(() {
        if (settings != null) {
          _hostController.text = settings.nasHost;
          _portController.text = settings.nasPort.toString();
          _usernameController.text = settings.nasUsername;
          _spaceThresholdController.text = settings.spaceWarnThresholdGb.toString();
          _useHttps = settings.useHttps;
          _notificationFlags = settings.notificationFlags;
          _defaultComparison = settings.defaultComparisonMethod;
          _defaultCompression = settings.defaultCompressionType;
          _backupExportPath = settings.backupExportPath;
        } else {
          _portController.text = '5006';
          _spaceThresholdController.text = '10';
        }
        _passwordController.text = password ?? '';
        _loading = false;
      });
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    try {
      final db = ref.read(databaseProvider);
      await db.settingsDao.upsertSettings(GlobalSettingsCompanion(
        id: const Value(1),
        nasHost: Value(_hostController.text.trim()),
        nasPort: Value(int.parse(_portController.text)),
        useHttps: Value(_useHttps),
        nasUsername: Value(_usernameController.text.trim()),
        defaultComparisonMethod: Value(_defaultComparison),
        defaultCompressionType: Value(_defaultCompression),
        spaceWarnThresholdGb: Value(int.tryParse(_spaceThresholdController.text) ?? 10),
        notificationFlags: Value(_notificationFlags),
      ));
      await _storage.saveNasPassword(_passwordController.text);

      // Invalidate so other screens see the update
      ref.invalidate(settingsProvider);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Settings saved')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _testConnection() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _testing = true;
      _connectionResult = null;
    });

    final svc = WebDavService(
      host: _hostController.text.trim(),
      port: int.parse(_portController.text),
      useHttps: _useHttps,
      username: _usernameController.text.trim(),
      password: _passwordController.text,
    );

    try {
      final ok = await svc.testConnection().timeout(const Duration(seconds: 10));
      if (mounted) setState(() => _connectionResult = ok);
    } catch (_) {
      if (mounted) setState(() => _connectionResult = false);
    } finally {
      svc.dispose();
      if (mounted) setState(() => _testing = false);
    }
  }

  Future<void> _pickExportDir() async {
    final dir = await FilePicker.platform.getDirectoryPath();
    if (dir == null || !mounted) return;
    setState(() => _backupExportPath = dir);
    final db = ref.read(databaseProvider);
    await db.settingsDao.upsertSettings(GlobalSettingsCompanion(
      id: const Value(1),
      backupExportPath: Value(dir),
    ));
  }

  Future<void> _exportNow() async {
    if (_backupExportPath == null) return;
    setState(() => _exporting = true);
    try {
      final db = ref.read(databaseProvider);
      final path = await _exportImportService.exportBackup(db, _backupExportPath!);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Backup saved: $path')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  Future<void> _importFromFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['zip'],
    );
    if (result == null || result.files.single.path == null || !mounted) return;
    final zipPath = result.files.single.path!;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Restore from backup?'),
        content: const Text(
          'This will replace all current data (jobs, run history, settings) '
          'with the contents of the selected backup.\n\n'
          'The app will restart immediately after restoring.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(ctx).colorScheme.error,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Restore'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    setState(() => _importing = true);
    try {
      final db = ref.read(databaseProvider);
      await _exportImportService.importBackup(db, zipPath);
      // importBackup calls exit(0) — unreachable
    } catch (e) {
      if (mounted) {
        setState(() => _importing = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Restore failed: $e')),
        );
      }
    }
  }

  void _toggleFlag(int flag) =>
      setState(() => _notificationFlags ^= flag);

  bool _hasFlag(int flag) => _notificationFlags & flag != 0;

  @override
  void dispose() {
    _hostController.dispose();
    _portController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _spaceThresholdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          if (_saving)
            const Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
            )
          else
            TextButton(onPressed: _save, child: const Text('Save')),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _sectionHeader('NAS Connection',
                icon: Icons.dns_rounded,
                infoTitle: 'NAS Connection',
                infoBody:
                    'Host / IP — the local IP address or hostname of your Synology NAS '
                    '(e.g. 192.168.1.100 or my-nas.local). Must be reachable from your phone.\n\n'
                    'Port — the WebDAV port on your NAS. Synology defaults: '
                    '5006 for HTTPS, 5005 for HTTP. Check DSM → Control Panel → File Services → WebDAV.\n\n'
                    'Use HTTPS — encrypts the connection. Certificate verification is disabled so '
                    'self-signed Synology certificates work fine on a home network or VPN. '
                    'Turn off only if your NAS does not have WebDAV HTTPS enabled.'),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    controller: _hostController,
                    decoration: const InputDecoration(
                      labelText: 'Host / IP',
                      hintText: '192.168.1.100',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.url,
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Required' : null,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _portController,
                    decoration: const InputDecoration(
                      labelText: 'Port',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (v) {
                      final n = int.tryParse(v ?? '');
                      return (n == null || n < 1 || n > 65535) ? 'Invalid' : null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              title: const Text('Use HTTPS'),
              subtitle: Text(_useHttps
                  ? 'Encrypted — certificate not verified (self-signed OK)'
                  : 'Plaintext HTTP — only use on trusted networks'),
              value: _useHttps,
              onChanged: (v) {
                setState(() {
                  _useHttps = v;
                  _portController.text = v ? '5006' : '5005';
                  _connectionResult = null;
                });
              },
            ),
            const SizedBox(height: 16),
            _sectionHeader('Credentials',
                icon: Icons.key_rounded,
                infoTitle: 'Credentials',
                infoBody:
                    'The Synology account used to authenticate WebDAV requests. '
                    'This should be a DSM user with read/write access to the folders you are backing up to.\n\n'
                    'The password is stored in Android Keystore (encrypted secure storage) — '
                    'it is never written to the app database or any plain-text file.'),
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(),
                suffixIcon: Tooltip(
                  message: _showPassword ? 'Hide password' : 'Show password',
                  child: IconButton(
                    icon: Icon(_showPassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () =>
                        setState(() => _showPassword = !_showPassword),
                  ),
                ),
              ),
              obscureText: !_showPassword,
            ),
            const SizedBox(height: 16),
            _ConnectionTestRow(
              onTest: _testConnection,
              testing: _testing,
              result: _connectionResult,
            ),
            const SizedBox(height: 24),
            _sectionHeader('Defaults (overridable per job)',
                icon: Icons.tune_rounded,
                infoTitle: 'Job Defaults',
                infoBody:
                    'These values pre-fill the Comparison Method and Compression fields when creating a new job. '
                    'Each job can override them individually — changing these defaults does not affect existing jobs.\n\n'
                    'Comparison method — how the app decides if a file needs re-uploading:\n'
                    '• Metadata (fast): checks file size + last-modified date.\n'
                    '• Hash MD5: computes a checksum — slower but catches content changes that don\'t update the date.\n'
                    '• Hash first run, metadata after: accurate baseline on first run, fast on subsequent runs.\n\n'
                    'Compression — whether to compress files before upload. '
                    'None is best for photos and video (already compressed). '
                    'Gzip/Zip can help for text files and documents.'),
            DropdownButtonFormField<ComparisonMethod>(
              initialValue: _defaultComparison,
              decoration: const InputDecoration(
                labelText: 'Default comparison method',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: ComparisonMethod.metadata,
                  child: Text('Metadata (fast)'),
                ),
                DropdownMenuItem(
                  value: ComparisonMethod.hash,
                  child: Text('Hash — MD5 (slow but definitive)'),
                ),
                DropdownMenuItem(
                  value: ComparisonMethod.hashThenMetadata,
                  child: Text('Hash first run, metadata after'),
                ),
              ],
              onChanged: (v) => setState(() => _defaultComparison = v!),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<CompressionType>(
              initialValue: _defaultCompression,
              decoration: const InputDecoration(
                labelText: 'Default compression',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: CompressionType.none, child: Text('None')),
                DropdownMenuItem(value: CompressionType.gzip, child: Text('Gzip')),
                DropdownMenuItem(value: CompressionType.zip, child: Text('Zip')),
              ],
              onChanged: (v) => setState(() => _defaultCompression = v!),
            ),
            const SizedBox(height: 24),
            _sectionHeader('Storage Warning',
                icon: Icons.sd_storage_rounded,
                infoTitle: 'Storage Warning',
                infoBody:
                    'After each backup run, the app checks the free space on the NAS via WebDAV. '
                    'If free space drops below this threshold, you\'ll receive a notification.\n\n'
                    'Set to 0 to disable the warning entirely. '
                    'A value of 10 (GB) is a reasonable default for most home NAS setups.'),
            TextFormField(
              controller: _spaceThresholdController,
              decoration: const InputDecoration(
                labelText: 'Warn when NAS free space below (GB)',
                hintText: '0 to disable',
                border: OutlineInputBorder(),
                helperText:
                    'You\'ll get a notification when the NAS falls below this threshold.',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 24),
            _sectionHeader('Notifications',
                icon: Icons.notifications_outlined,
                infoTitle: 'Notifications',
                infoBody:
                    'Choose which events trigger a notification. All are enabled by default.\n\n'
                    '• Job failed — the entire job errored out before uploading anything.\n'
                    '• Partial failure — job finished but one or more files could not be uploaded.\n'
                    '• File skipped (locked) — a file was in use by another app and could not be read.\n'
                    '• Low NAS storage — free space dropped below your threshold after a run.\n'
                    '• Retention cleanup — old Living File snapshots were deleted by a retention rule.\n'
                    '• Job completed successfully — fires on every successful run; can be noisy if jobs run frequently.'),
            _NotifCheckbox(
              label: 'Job failed',
              value: _hasFlag(kNotifyJobFailed),
              onChanged: (_) => _toggleFlag(kNotifyJobFailed),
              tooltip: 'Notify when a job fails entirely with no files uploaded',
            ),
            _NotifCheckbox(
              label: 'Partial failure (some files failed)',
              value: _hasFlag(kNotifyPartialFailure),
              onChanged: (_) => _toggleFlag(kNotifyPartialFailure),
              tooltip: 'Notify when a job completes but some files could not be uploaded',
            ),
            _NotifCheckbox(
              label: 'File skipped (locked / open)',
              value: _hasFlag(kNotifyFileLocked),
              onChanged: (_) => _toggleFlag(kNotifyFileLocked),
              tooltip: 'Notify when a file is skipped because another app has it open',
            ),
            _NotifCheckbox(
              label: 'Low NAS storage',
              value: _hasFlag(kNotifyLowSpace),
              onChanged: (_) => _toggleFlag(kNotifyLowSpace),
              tooltip: 'Notify when NAS free space drops below your threshold',
            ),
            _NotifCheckbox(
              label: 'Retention cleanup completed',
              value: _hasFlag(kNotifyRetentionCleanup),
              onChanged: (_) => _toggleFlag(kNotifyRetentionCleanup),
              tooltip: 'Notify when old versioned files are pruned by retention rules',
            ),
            _NotifCheckbox(
              label: 'Job completed successfully (may be noisy)',
              value: _hasFlag(kNotifySuccess),
              onChanged: (_) => _toggleFlag(kNotifySuccess),
              tooltip: 'Notify on every successful run — can be frequent if jobs run often',
            ),
            const SizedBox(height: 24),
            _sectionHeader('App Backup',
                icon: Icons.save_rounded,
                infoTitle: 'App Backup',
                infoBody:
                    'This backs up the app itself — your jobs, run history, and settings — '
                    'not the files on your NAS.\n\n'
                    'Export Now saves a .zip file containing the SQLite database to the folder you choose. '
                    'Use this before uninstalling or switching phones.\n\n'
                    'Import Backup restores from a previously exported .zip, replacing all current data. '
                    'The app restarts immediately after a successful import.'),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _backupExportPath ?? 'No export location set',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: _backupExportPath == null
                              ? Theme.of(context).colorScheme.onSurfaceVariant
                              : null,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Tooltip(
                  message: 'Choose the folder where app backups (.zip) will be saved',
                  child: IconButton(
                    icon: const Icon(Icons.folder_open_rounded),
                    onPressed: _pickExportDir,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Tooltip(
                    message: 'Export all jobs, run history and settings as a .zip file',
                    child: OutlinedButton.icon(
                      onPressed: (_backupExportPath != null && !_exporting)
                          ? _exportNow
                          : null,
                      icon: _exporting
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.upload_file_rounded),
                      label: const Text('Export Now'),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Tooltip(
                    message: 'Restore from a previously exported .zip — replaces all current data',
                    child: OutlinedButton.icon(
                      onPressed: _importing ? null : _importFromFile,
                      icon: _importing
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.download_rounded),
                      label: const Text('Import Backup'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title,
          {IconData? icon, String? infoTitle, String? infoBody}) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon,
                  size: 15, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 6),
            ],
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            if (infoTitle != null && infoBody != null) ...[
              const SizedBox(width: 4),
              _InfoButton(title: infoTitle, body: infoBody),
            ],
          ],
        ),
      );
}

class _InfoButton extends StatelessWidget {
  final String title;
  final String body;

  const _InfoButton({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.info_outline,
          size: 16,
          color: Theme.of(context).colorScheme.onSurfaceVariant),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      visualDensity: VisualDensity.compact,
      tooltip: 'What is this?',
      onPressed: () => showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Got it'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConnectionTestRow extends StatelessWidget {
  final VoidCallback onTest;
  final bool testing;
  final bool? result;

  const _ConnectionTestRow({
    required this.onTest,
    required this.testing,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Tooltip(
          message: 'Verify the NAS connection using the credentials above (10s timeout)',
          child: OutlinedButton.icon(
            onPressed: testing ? null : onTest,
            icon: testing
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.network_check_rounded),
            label: const Text('Test connection'),
          ),
        ),
        const SizedBox(width: 12),
        if (result == true)
          const Row(children: [
            Icon(Icons.check_circle, color: Colors.green, size: 20),
            SizedBox(width: 4),
            Text('Connected', style: TextStyle(color: Colors.green)),
          ])
        else if (result == false)
          const Row(children: [
            Icon(Icons.error, color: Colors.red, size: 20),
            SizedBox(width: 4),
            Text('Failed', style: TextStyle(color: Colors.red)),
          ]),
      ],
    );
  }
}

class _NotifCheckbox extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String? tooltip;

  const _NotifCheckbox({
    required this.label,
    required this.value,
    required this.onChanged,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    Widget tile = CheckboxListTile(
      title: Text(label),
      value: value,
      onChanged: onChanged,
      dense: true,
      contentPadding: EdgeInsets.zero,
    );
    if (tooltip != null) {
      tile = Tooltip(message: tooltip!, child: tile);
    }
    return tile;
  }
}
