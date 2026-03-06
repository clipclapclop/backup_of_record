// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'runs_dao.dart';

// ignore_for_file: type=lint
mixin _$RunsDaoMixin on DatabaseAccessor<AppDatabase> {
  $JobsTable get jobs => attachedDatabase.jobs;
  $JobRunsTable get jobRuns => attachedDatabase.jobRuns;
  RunsDaoManager get managers => RunsDaoManager(this);
}

class RunsDaoManager {
  final _$RunsDaoMixin _db;
  RunsDaoManager(this._db);
  $$JobsTableTableManager get jobs =>
      $$JobsTableTableManager(_db.attachedDatabase, _db.jobs);
  $$JobRunsTableTableManager get jobRuns =>
      $$JobRunsTableTableManager(_db.attachedDatabase, _db.jobRuns);
}
