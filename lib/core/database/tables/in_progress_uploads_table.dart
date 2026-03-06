import 'package:drift/drift.dart';
import 'jobs_table.dart';

/// Tracks uploads that started but haven't completed (crash recovery).
/// On each run start: check this table, try to resume or clean up .part files.
class InProgressUploads extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get jobId => integer().references(Jobs, #id)();

  TextColumn get localPath => text()();
  TextColumn get nasTempPath => text()(); // the .part file on NAS
  TextColumn get nasFinalPath => text()(); // where it goes when complete

  IntColumn get bytesUploaded => integer().withDefault(const Constant(0))();
  IntColumn get totalBytes => integer()();

  DateTimeColumn get startedAt => dateTime()();
}
