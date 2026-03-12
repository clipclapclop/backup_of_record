import 'package:drift/drift.dart' show Value;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/database/tables/jobs_table.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/database_provider.dart';
import '../../../core/providers/settings_provider.dart';
import '../../../core/services/scheduling_service.dart';

class JobCreateScreen extends ConsumerStatefulWidget {
  const JobCreateScreen({super.key});

  @override
  ConsumerState<JobCreateScreen> createState() => _JobCreateScreenState();
}

class _JobCreateScreenState extends ConsumerState<JobCreateScreen> {
  final _formKey = GlobalKey<FormState>();

  // Common
  final _nameController = TextEditingController();
  final _sourceController = TextEditingController();
  final _destinationController = TextEditingController();

  JobType _jobType = JobType.folderBackup;
  ScheduleType _scheduleType = ScheduleType.daily;
  ComparisonMethod _comparisonMethod = ComparisonMethod.metadata;
  CompressionType _compressionType = CompressionType.none;
  BackupStrategy _backupStrategy = BackupStrategy.incremental;

  // Schedule config
  TimeOfDay _dailyTime = const TimeOfDay(hour: 2, minute: 0);
  int _pollingMinutes = 60;

  // From-date strategy
  DateTime? _fromDate;

  // Type A
  ChangePolicy _changePolicy = ChangePolicy.archiveOnly;

  // Type B retention
  final _retentionCountController = TextEditingController(text: '10');
  final _retentionDaysController = TextEditingController(text: '90');
  bool _useRetentionCount = true;
  bool _useRetentionDays = false;

  bool _saving = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _applyDefaults());
  }

  void _applyDefaults() {
    final settings = ref.read(settingsProvider).valueOrNull;
    if (settings != null) {
      setState(() {
        _comparisonMethod = settings.defaultComparisonMethod;
        _compressionType = settings.defaultCompressionType;
      });
    }
  }

  Future<void> _pickSource() async {
    if (_jobType == JobType.folderBackup) {
      final result = await FilePicker.platform.getDirectoryPath();
      if (result != null && mounted) {
        setState(() => _sourceController.text = result);
      }
    } else {
      final result = await FilePicker.platform.pickFiles(allowMultiple: false);
      if (result != null && result.files.single.path != null && mounted) {
        setState(() => _sourceController.text = result.files.single.path!);
      }
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _dailyTime,
    );
    if (picked != null) setState(() => _dailyTime = picked);
  }

  Future<void> _pickFromDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _fromDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _fromDate = picked);
  }

  String _scheduleConfig() => switch (_scheduleType) {
        ScheduleType.daily =>
          '${_dailyTime.hour.toString().padLeft(2, '0')}:${_dailyTime.minute.toString().padLeft(2, '0')}',
        ScheduleType.onChange => _pollingMinutes.toString(),
        _ => '',
      };

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    if (_jobType == JobType.livingFile &&
        !_useRetentionCount &&
        !_useRetentionDays) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Set at least one retention rule (count or days)')));
      return;
    }

    setState(() => _saving = true);
    try {
      final db = ref.read(databaseProvider);
      final id = await db.jobsDao.insertJob(JobsCompanion(
        name: Value(_nameController.text.trim()),
        jobType: Value(_jobType),
        sourcePath: Value(_sourceController.text.trim()),
        destinationNasPath: Value(_destinationController.text.trim()),
        scheduleType: Value(_scheduleType),
        scheduleConfig: Value(_scheduleConfig()),
        backupStrategy: Value(_backupStrategy),
        fromDate: Value(
            _backupStrategy == BackupStrategy.fromDate ? _fromDate : null),
        comparisonMethod: Value(_comparisonMethod),
        changePolicy: Value(
            _jobType == JobType.folderBackup ? _changePolicy : null),
        compressionType: Value(_compressionType),
        retentionCount: Value(
            _jobType == JobType.livingFile && _useRetentionCount
                ? int.tryParse(_retentionCountController.text)
                : null),
        retentionDays: Value(
            _jobType == JobType.livingFile && _useRetentionDays
                ? int.tryParse(_retentionDaysController.text)
                : null),
        isEnabled: const Value(true),
        createdAt: Value(DateTime.now()),
      ));
      // Schedule the job in WorkManager
      final job = await db.jobsDao.getJob(id);
      if (job != null) await SchedulingService.scheduleJob(job);

      if (mounted) context.go('/jobs/$id');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _sourceController.dispose();
    _destinationController.dispose();
    _retentionCountController.dispose();
    _retentionDaysController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Backup Job'),
        actions: [
          if (_saving)
            const Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2)),
            )
          else
            TextButton(onPressed: _save, child: const Text('Create')),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _sectionHeader('Job', icon: Icons.label_rounded),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Job name',
                hintText: 'e.g. Camera Photos',
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            _sectionHeader('Type', icon: Icons.category_rounded),
            SegmentedButton<JobType>(
              segments: const [
                ButtonSegment(
                  value: JobType.folderBackup,
                  label: Text('Folder backup'),
                  icon: Icon(Icons.folder),
                ),
                ButtonSegment(
                  value: JobType.livingFile,
                  label: Text('Living file'),
                  icon: Icon(Icons.description),
                ),
              ],
              selected: {_jobType},
              onSelectionChanged: (s) => setState(() {
                _jobType = s.first;
                _sourceController.clear();
                // onChange schedule only applies to living files
                if (_jobType == JobType.folderBackup &&
                    _scheduleType == ScheduleType.onChange) {
                  _scheduleType = ScheduleType.daily;
                }
              }),
            ),
            const SizedBox(height: 4),
            Text(
              _jobType == JobType.folderBackup
                  ? 'Backs up all files in a folder recursively.'
                  : 'Backs up a single file as timestamped snapshots with retention.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            _sectionHeader('Source & Destination', icon: Icons.swap_horiz_rounded),
            TextFormField(
              controller: _sourceController,
              decoration: InputDecoration(
                labelText: _jobType == JobType.folderBackup
                    ? 'Source folder on phone'
                    : 'Source file on phone',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.folder_open),
                  onPressed: _pickSource,
                ),
              ),
              readOnly: true,
              onTap: _pickSource,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required — tap to browse' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _destinationController,
              decoration: const InputDecoration(
                labelText: 'Destination path on NAS',
                hintText: '/backups/phone/photos',
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 24),

            // ── Type A: Change policy ───────────────────────────────────────
            if (_jobType == JobType.folderBackup) ...[
              _sectionHeader('Change Policy', icon: Icons.change_circle_outlined),
              RadioGroup<ChangePolicy>(
                groupValue: _changePolicy,
                onChanged: (v) => setState(() => _changePolicy = v!),
                child: Column(
                  children: [
                    (
                      ChangePolicy.archiveOnly,
                      'Archive only',
                      'Once backed up, never re-upload even if the file changes. Best for photos.',
                    ),
                    (
                      ChangePolicy.overwrite,
                      'Overwrite',
                      'Re-upload changed files, replacing the NAS copy.',
                    ),
                    (
                      ChangePolicy.versionOnChange,
                      'Version on change',
                      'Keep original name; append timestamp to each new version.',
                    ),
                  ]
                      .map((e) => RadioListTile<ChangePolicy>(
                            value: e.$1,
                            title: Text(e.$2),
                            subtitle: Text(e.$3,
                                style: Theme.of(context).textTheme.bodySmall),
                            contentPadding: EdgeInsets.zero,
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 8),
            ],

            // ── Type B: Retention ───────────────────────────────────────────
            if (_jobType == JobType.livingFile) ...[
              _sectionHeader('Retention', icon: Icons.layers_rounded),
              CheckboxListTile(
                title: const Text('Keep last N versions'),
                value: _useRetentionCount,
                onChanged: (v) => setState(() => _useRetentionCount = v!),
                contentPadding: EdgeInsets.zero,
                dense: true,
              ),
              if (_useRetentionCount)
                Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 8),
                  child: TextFormField(
                    controller: _retentionCountController,
                    decoration: const InputDecoration(
                      labelText: 'Number of versions',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              CheckboxListTile(
                title: const Text('Keep versions for Y days'),
                value: _useRetentionDays,
                onChanged: (v) => setState(() => _useRetentionDays = v!),
                contentPadding: EdgeInsets.zero,
                dense: true,
              ),
              if (_useRetentionDays)
                Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 8),
                  child: TextFormField(
                    controller: _retentionDaysController,
                    decoration: const InputDecoration(
                      labelText: 'Days',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'If both rules are set, a version is kept if either rule says to keep it.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],

            _sectionHeader('Schedule', icon: Icons.schedule_rounded),
            DropdownButtonFormField<ScheduleType>(
              initialValue: _scheduleType,
              decoration: const InputDecoration(
                labelText: 'Run schedule',
                border: OutlineInputBorder(),
              ),
              items: [
                const DropdownMenuItem(
                    value: ScheduleType.manual, child: Text('Manual only')),
                const DropdownMenuItem(
                    value: ScheduleType.daily, child: Text('Daily')),
                const DropdownMenuItem(
                    value: ScheduleType.weekly, child: Text('Weekly')),
                if (_jobType == JobType.livingFile)
                  const DropdownMenuItem(
                    value: ScheduleType.onChange,
                    child: Text('When file changes (poll)'),
                  ),
              ],
              onChanged: (v) => setState(() => _scheduleType = v!),
            ),
            if (_scheduleType == ScheduleType.daily) ...[
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Run time'),
                trailing: TextButton(
                  onPressed: _pickTime,
                  child: Text(_dailyTime.format(context)),
                ),
              ),
            ],
            if (_scheduleType == ScheduleType.onChange) ...[
              const SizedBox(height: 12),
              TextFormField(
                initialValue: _pollingMinutes.toString(),
                decoration: const InputDecoration(
                  labelText: 'Check for changes every (minutes)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (v) =>
                    _pollingMinutes = int.tryParse(v) ?? _pollingMinutes,
              ),
            ],
            const SizedBox(height: 24),
            _sectionHeader('What to Back Up', icon: Icons.filter_list_rounded),
            DropdownButtonFormField<BackupStrategy>(
              initialValue: _backupStrategy,
              decoration: const InputDecoration(
                labelText: 'Backup strategy',
                border: OutlineInputBorder(),
                helperText:
                    'Incremental only processes files changed since the last run. Full re-evaluates everything every time.',
                helperMaxLines: 2,
              ),
              items: const [
                DropdownMenuItem(
                  value: BackupStrategy.incremental,
                  child: Text('Incremental (since last run)'),
                ),
                DropdownMenuItem(
                  value: BackupStrategy.fromDate,
                  child: Text('From a specific date forward'),
                ),
                DropdownMenuItem(
                  value: BackupStrategy.full,
                  child: Text('Full (re-evaluate everything each run)'),
                ),
              ],
              onChanged: (v) => setState(() => _backupStrategy = v!),
            ),
            if (_backupStrategy == BackupStrategy.fromDate) ...[
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Only files modified on or after'),
                trailing: TextButton(
                  onPressed: _pickFromDate,
                  child: Text(_fromDate == null
                      ? 'Pick date'
                      : '${_fromDate!.year}-${_fromDate!.month.toString().padLeft(2, '0')}-${_fromDate!.day.toString().padLeft(2, '0')}'),
                ),
              ),
            ],
            const SizedBox(height: 24),
            _sectionHeader('Comparison & Compression', icon: Icons.compare_arrows_rounded),
            DropdownButtonFormField<ComparisonMethod>(
              initialValue: _comparisonMethod,
              decoration: const InputDecoration(
                labelText: 'Comparison method',
                border: OutlineInputBorder(),
                helperText:
                    'Metadata uses file size + date. Hash is slower but catches content changes.',
                helperMaxLines: 2,
              ),
              items: const [
                DropdownMenuItem(
                    value: ComparisonMethod.metadata,
                    child: Text('Metadata (fast)')),
                DropdownMenuItem(
                    value: ComparisonMethod.hash,
                    child: Text('Hash — MD5 (definitive)')),
                DropdownMenuItem(
                    value: ComparisonMethod.hashThenMetadata,
                    child: Text('Hash first run, metadata after')),
              ],
              onChanged: (v) => setState(() => _comparisonMethod = v!),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<CompressionType>(
              initialValue: _compressionType,
              decoration: const InputDecoration(
                labelText: 'Compression',
                border: OutlineInputBorder(),
                helperText:
                    'Compress files before uploading. Not recommended for already-compressed media (photos, video).',
                helperMaxLines: 2,
              ),
              items: const [
                DropdownMenuItem(
                    value: CompressionType.none, child: Text('None')),
                DropdownMenuItem(
                    value: CompressionType.gzip, child: Text('Gzip')),
                DropdownMenuItem(
                    value: CompressionType.zip, child: Text('Zip')),
              ],
              onChanged: (v) => setState(() => _compressionType = v!),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, {IconData? icon}) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon,
                  size: 15,
                  color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 6),
            ],
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      );
}
