import 'package:drift/drift.dart';
import '../../../core/database/tables/jobs_table.dart';

/// Single-row table for non-sensitive global settings.
/// NAS password is stored separately in flutter_secure_storage.
class GlobalSettings extends Table {
  // Always ID = 1 (single row)
  IntColumn get id => integer().autoIncrement()();

  TextColumn get nasHost => text().withDefault(const Constant(''))();
  IntColumn get nasPort => integer().withDefault(const Constant(5006))();
  BoolColumn get useHttps => boolean().withDefault(const Constant(true))();

  TextColumn get nasUsername => text().withDefault(const Constant(''))();

  IntColumn get defaultComparisonMethod =>
      intEnum<ComparisonMethod>().withDefault(Constant(ComparisonMethod.metadata.index))();
  IntColumn get defaultCompressionType =>
      intEnum<CompressionType>().withDefault(Constant(CompressionType.none.index))();

  // Warn if NAS free space falls below this many GB (0 = disabled)
  IntColumn get spaceWarnThresholdGb =>
      integer().withDefault(const Constant(10))();

  // Which notification events to show (stored as a bitmask int)
  IntColumn get notificationFlags =>
      integer().withDefault(const Constant(0xFF))();

  // Filesystem path where the app backup zip is saved (null = not set).
  // Must be a raw path (e.g. /storage/emulated/0/Documents/backup.zip),
  // not a SAF content URI — so BackupEngine can string-match it against a
  // job's sourcePath and auto-regenerate the zip before uploading.
  TextColumn get backupExportPath => text().nullable()();

  // True when jobs/settings have changed since the last self-export.
  // BackupEngine checks this before regenerating the zip during a self-backup.
  BoolColumn get autoBackupDirty => boolean().withDefault(const Constant(true))();

  // When the self-export last wrote successfully (null = never).
  DateTimeColumn get autoBackupLastExportAt => dateTime().nullable()();

  // Default run time for new jobs (24-hour components)
  IntColumn get defaultJobHour => integer().withDefault(const Constant(2))();
  IntColumn get defaultJobMinute => integer().withDefault(const Constant(0))();
}
