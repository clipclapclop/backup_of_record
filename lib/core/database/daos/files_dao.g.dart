// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'files_dao.dart';

// ignore_for_file: type=lint
mixin _$FilesDaoMixin on DatabaseAccessor<AppDatabase> {
  $JobsTable get jobs => attachedDatabase.jobs;
  $FileRecordsTable get fileRecords => attachedDatabase.fileRecords;
  $JobRunsTable get jobRuns => attachedDatabase.jobRuns;
  $FileRunLogsTable get fileRunLogs => attachedDatabase.fileRunLogs;
  $InProgressUploadsTable get inProgressUploads =>
      attachedDatabase.inProgressUploads;
  FilesDaoManager get managers => FilesDaoManager(this);
}

class FilesDaoManager {
  final _$FilesDaoMixin _db;
  FilesDaoManager(this._db);
  $$JobsTableTableManager get jobs =>
      $$JobsTableTableManager(_db.attachedDatabase, _db.jobs);
  $$FileRecordsTableTableManager get fileRecords =>
      $$FileRecordsTableTableManager(_db.attachedDatabase, _db.fileRecords);
  $$JobRunsTableTableManager get jobRuns =>
      $$JobRunsTableTableManager(_db.attachedDatabase, _db.jobRuns);
  $$FileRunLogsTableTableManager get fileRunLogs =>
      $$FileRunLogsTableTableManager(_db.attachedDatabase, _db.fileRunLogs);
  $$InProgressUploadsTableTableManager get inProgressUploads =>
      $$InProgressUploadsTableTableManager(
        _db.attachedDatabase,
        _db.inProgressUploads,
      );
}
