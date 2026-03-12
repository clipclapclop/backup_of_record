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

  // Directory path where backup zips are saved (null = not set)
  TextColumn get backupExportPath => text().nullable()();
}
