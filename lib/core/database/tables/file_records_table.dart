import 'package:drift/drift.dart';
import 'jobs_table.dart';

enum FileStatus { ok, failed, skipped, locked }

/// One row per file tracked by a job.
/// For Type A: relative_path is relative to the source folder.
/// For Type B: relative_path is the filename; nas_path includes the timestamp suffix.
class FileRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get jobId => integer().references(Jobs, #id)();

  // Path on phone, relative to the job's source root
  TextColumn get relativePath => text()();

  // Full NAS path of the backed-up file (may include timestamp for Type B)
  TextColumn get nasPath => text()();

  IntColumn get sizeBytes => integer()();
  DateTimeColumn get lastModified => dateTime()();

  // Null when comparison method is metadata-only
  TextColumn get hash => text().nullable()();

  DateTimeColumn get lastBackedUpAt => dateTime().nullable()();
  IntColumn get lastStatus => intEnum<FileStatus>()();
}
