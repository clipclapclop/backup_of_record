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
  int get schemaVersion => 8;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.addColumn(globalSettings, globalSettings.backupExportPath);
      }
      if (from < 3) {
        await m.addColumn(jobs, jobs.wifiOnly);
      }
      if (from < 4) {
        await m.addColumn(jobRuns, jobRuns.isDryRun);
        await m.addColumn(jobRuns, jobRuns.cancelRequested);
      }
      if (from < 5) {
        await m.database.customStatement(
          'ALTER TABLE global_settings ADD COLUMN default_job_hour INTEGER NOT NULL DEFAULT 2',
        );
        await m.database.customStatement(
          'ALTER TABLE global_settings ADD COLUMN default_job_minute INTEGER NOT NULL DEFAULT 0',
        );
      }
      if (from < 6) {
        // Remove duplicate file_records rows — keep only the most recently
        // backed-up row for each (job_id, relative_path) pair.
        await m.database.customStatement('''
          DELETE FROM file_records
          WHERE id NOT IN (
            SELECT MAX(id) FROM file_records
            GROUP BY job_id, relative_path
          )
        ''');
        // Add unique index so insertOnConflictUpdate targets (job_id, relative_path)
        await m.database.customStatement('''
          CREATE UNIQUE INDEX file_records_job_path
          ON file_records (job_id, relative_path)
        ''');
      }
      if (from < 7) {
        await m.addColumn(globalSettings, globalSettings.autoBackupDirty);
        await m.addColumn(
            globalSettings, globalSettings.autoBackupLastExportAt);
        // Existing backupExportPath values are SAF content:// URIs from the
        // old flow; the new code expects raw filesystem paths. Wipe so the
        // user re-picks via the file browser.
        await m.database.customStatement(
          "UPDATE global_settings SET backup_export_path = NULL "
          "WHERE backup_export_path LIKE 'content://%'",
        );
      }
      if (from < 8) {
        await m.addColumn(jobs, jobs.sortOrder);
        // Preserve existing display order by seeding sortOrder from id.
        await m.database.customStatement(
          'UPDATE jobs SET sort_order = id',
        );
      }
    },
  );

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'backup_of_record',
      native: DriftNativeOptions(
        // Serialise all DB access through a single shared isolate so that
        // multiple connections (main UI + WorkManager background isolate)
        // don't fight for the SQLite file lock.
        shareAcrossIsolates: true,
        setup: (db) {
          // WAL mode allows concurrent readers alongside a single writer.
          db.execute('PRAGMA journal_mode=WAL');
          // If the shared-isolate path can't be used (e.g. independent
          // Flutter engines), a busy timeout prevents an immediate
          // "database is locked" error — SQLite retries for up to 5 s.
          db.execute('PRAGMA busy_timeout=5000');
        },
      ),
    );
  }
}
