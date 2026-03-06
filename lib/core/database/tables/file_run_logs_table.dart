import 'package:drift/drift.dart';
import 'job_runs_table.dart';
import 'file_records_table.dart';

enum FileAction { uploaded, skipped, failed, locked, retentionDeleted }

/// Verbose per-file outcome for each job run (optional/verbose mode).
class FileRunLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get runId => integer().references(JobRuns, #id)();
  IntColumn get fileRecordId => integer().references(FileRecords, #id).nullable()();

  IntColumn get action => intEnum<FileAction>()();
  TextColumn get filePath => text()(); // denormalised for easy display
  TextColumn get errorMessage => text().nullable()();
  DateTimeColumn get occurredAt => dateTime()();
}
