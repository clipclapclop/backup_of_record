import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/jobs_table.dart';
import 'tables/job_runs_table.dart';
import 'tables/file_records_table.dart';
import 'tables/file_run_logs_table.dart';
import 'tables/in_progress_uploads_table.dart';
import 'tables/global_settings_table.dart';
import 'daos/jobs_dao.dart';
import 'daos/runs_dao.dart';
import 'daos/files_dao.dart';
import 'daos/settings_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Jobs,
    JobRuns,
    FileRecords,
    FileRunLogs,
    InProgressUploads,
    GlobalSettings,
  ],
  daos: [
    JobsDao,
    RunsDao,
    FilesDao,
    SettingsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'backup_of_record');
  }
}
