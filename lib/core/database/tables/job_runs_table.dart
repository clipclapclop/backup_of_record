import 'package:drift/drift.dart';
import 'jobs_table.dart';

enum RunStatus { running, success, partial, failed, cancelled, dryRun, queued }

class JobRuns extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get jobId => integer().references(Jobs, #id)();

  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  IntColumn get status => intEnum<RunStatus>()();
  BoolColumn get isDryRun =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get cancelRequested =>
      boolean().withDefault(const Constant(false))();

  IntColumn get filesScanned => integer().withDefault(const Constant(0))();
  IntColumn get filesUploaded => integer().withDefault(const Constant(0))();
  IntColumn get filesSkipped => integer().withDefault(const Constant(0))();
  IntColumn get filesFailed => integer().withDefault(const Constant(0))();
  IntColumn get bytesTransferred => integer().withDefault(const Constant(0))();

  TextColumn get errorSummary => text().nullable()();
}
