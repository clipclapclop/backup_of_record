import 'package:drift/drift.dart';

/// Backup strategy: what scope of files to consider each run.
enum BackupStrategy { full, fromDate, incremental }

/// For Type A (folder): what to do when a tracked file changes on the phone.
enum ChangePolicy { archiveOnly, overwrite, versionOnChange }

/// How to detect whether a file has changed.
enum ComparisonMethod { metadata, hash, hashThenMetadata }

/// Compression applied before upload.
enum CompressionType { none, gzip, zip }

/// How often the job runs.
enum ScheduleType { manual, daily, weekly, onChange }

/// High-level job type.
enum JobType { folderBackup, livingFile }

class Jobs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get jobType => intEnum<JobType>()();

  // Source / destination
  TextColumn get sourcePath => text()();
  TextColumn get destinationNasPath => text()();

  // Schedule
  IntColumn get scheduleType => intEnum<ScheduleType>()();
  // For daily/weekly: "HH:mm" or "Mon,14:30". For onChange: polling minutes.
  TextColumn get scheduleConfig => text().nullable()();

  // Backup logic
  IntColumn get backupStrategy => intEnum<BackupStrategy>()();
  DateTimeColumn get fromDate => dateTime().nullable()();
  IntColumn get comparisonMethod => intEnum<ComparisonMethod>()();

  // Type A only
  IntColumn get changePolicy => intEnum<ChangePolicy>().nullable()();

  // Compression
  IntColumn get compressionType => intEnum<CompressionType>()();

  // Type B retention
  IntColumn get retentionCount => integer().nullable()();
  IntColumn get retentionDays => integer().nullable()();

  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get lastRunAt => dateTime().nullable()();
  // last run status stored as string (success/partial/failed/never)
  TextColumn get lastRunStatus => text().nullable()();
}
