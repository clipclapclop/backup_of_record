// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $JobsTable extends Jobs with TableInfo<$JobsTable, Job> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JobsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<JobType, int> jobType =
      GeneratedColumn<int>(
        'job_type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<JobType>($JobsTable.$converterjobType);
  static const VerificationMeta _sourcePathMeta = const VerificationMeta(
    'sourcePath',
  );
  @override
  late final GeneratedColumn<String> sourcePath = GeneratedColumn<String>(
    'source_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _destinationNasPathMeta =
      const VerificationMeta('destinationNasPath');
  @override
  late final GeneratedColumn<String> destinationNasPath =
      GeneratedColumn<String>(
        'destination_nas_path',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  @override
  late final GeneratedColumnWithTypeConverter<ScheduleType, int> scheduleType =
      GeneratedColumn<int>(
        'schedule_type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<ScheduleType>($JobsTable.$converterscheduleType);
  static const VerificationMeta _scheduleConfigMeta = const VerificationMeta(
    'scheduleConfig',
  );
  @override
  late final GeneratedColumn<String> scheduleConfig = GeneratedColumn<String>(
    'schedule_config',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<BackupStrategy, int>
  backupStrategy = GeneratedColumn<int>(
    'backup_strategy',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  ).withConverter<BackupStrategy>($JobsTable.$converterbackupStrategy);
  static const VerificationMeta _fromDateMeta = const VerificationMeta(
    'fromDate',
  );
  @override
  late final GeneratedColumn<DateTime> fromDate = GeneratedColumn<DateTime>(
    'from_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ComparisonMethod, int>
  comparisonMethod = GeneratedColumn<int>(
    'comparison_method',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  ).withConverter<ComparisonMethod>($JobsTable.$convertercomparisonMethod);
  @override
  late final GeneratedColumnWithTypeConverter<ChangePolicy?, int> changePolicy =
      GeneratedColumn<int>(
        'change_policy',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<ChangePolicy?>($JobsTable.$converterchangePolicyn);
  @override
  late final GeneratedColumnWithTypeConverter<CompressionType, int>
  compressionType = GeneratedColumn<int>(
    'compression_type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  ).withConverter<CompressionType>($JobsTable.$convertercompressionType);
  static const VerificationMeta _retentionCountMeta = const VerificationMeta(
    'retentionCount',
  );
  @override
  late final GeneratedColumn<int> retentionCount = GeneratedColumn<int>(
    'retention_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _retentionDaysMeta = const VerificationMeta(
    'retentionDays',
  );
  @override
  late final GeneratedColumn<int> retentionDays = GeneratedColumn<int>(
    'retention_days',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastRunAtMeta = const VerificationMeta(
    'lastRunAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastRunAt = GeneratedColumn<DateTime>(
    'last_run_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastRunStatusMeta = const VerificationMeta(
    'lastRunStatus',
  );
  @override
  late final GeneratedColumn<String> lastRunStatus = GeneratedColumn<String>(
    'last_run_status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    jobType,
    sourcePath,
    destinationNasPath,
    scheduleType,
    scheduleConfig,
    backupStrategy,
    fromDate,
    comparisonMethod,
    changePolicy,
    compressionType,
    retentionCount,
    retentionDays,
    isEnabled,
    createdAt,
    lastRunAt,
    lastRunStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'jobs';
  @override
  VerificationContext validateIntegrity(
    Insertable<Job> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('source_path')) {
      context.handle(
        _sourcePathMeta,
        sourcePath.isAcceptableOrUnknown(data['source_path']!, _sourcePathMeta),
      );
    } else if (isInserting) {
      context.missing(_sourcePathMeta);
    }
    if (data.containsKey('destination_nas_path')) {
      context.handle(
        _destinationNasPathMeta,
        destinationNasPath.isAcceptableOrUnknown(
          data['destination_nas_path']!,
          _destinationNasPathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_destinationNasPathMeta);
    }
    if (data.containsKey('schedule_config')) {
      context.handle(
        _scheduleConfigMeta,
        scheduleConfig.isAcceptableOrUnknown(
          data['schedule_config']!,
          _scheduleConfigMeta,
        ),
      );
    }
    if (data.containsKey('from_date')) {
      context.handle(
        _fromDateMeta,
        fromDate.isAcceptableOrUnknown(data['from_date']!, _fromDateMeta),
      );
    }
    if (data.containsKey('retention_count')) {
      context.handle(
        _retentionCountMeta,
        retentionCount.isAcceptableOrUnknown(
          data['retention_count']!,
          _retentionCountMeta,
        ),
      );
    }
    if (data.containsKey('retention_days')) {
      context.handle(
        _retentionDaysMeta,
        retentionDays.isAcceptableOrUnknown(
          data['retention_days']!,
          _retentionDaysMeta,
        ),
      );
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_run_at')) {
      context.handle(
        _lastRunAtMeta,
        lastRunAt.isAcceptableOrUnknown(data['last_run_at']!, _lastRunAtMeta),
      );
    }
    if (data.containsKey('last_run_status')) {
      context.handle(
        _lastRunStatusMeta,
        lastRunStatus.isAcceptableOrUnknown(
          data['last_run_status']!,
          _lastRunStatusMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Job map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Job(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      jobType: $JobsTable.$converterjobType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}job_type'],
        )!,
      ),
      sourcePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_path'],
      )!,
      destinationNasPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}destination_nas_path'],
      )!,
      scheduleType: $JobsTable.$converterscheduleType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}schedule_type'],
        )!,
      ),
      scheduleConfig: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}schedule_config'],
      ),
      backupStrategy: $JobsTable.$converterbackupStrategy.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}backup_strategy'],
        )!,
      ),
      fromDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}from_date'],
      ),
      comparisonMethod: $JobsTable.$convertercomparisonMethod.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}comparison_method'],
        )!,
      ),
      changePolicy: $JobsTable.$converterchangePolicyn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}change_policy'],
        ),
      ),
      compressionType: $JobsTable.$convertercompressionType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}compression_type'],
        )!,
      ),
      retentionCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retention_count'],
      ),
      retentionDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retention_days'],
      ),
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      lastRunAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_run_at'],
      ),
      lastRunStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_run_status'],
      ),
    );
  }

  @override
  $JobsTable createAlias(String alias) {
    return $JobsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<JobType, int, int> $converterjobType =
      const EnumIndexConverter<JobType>(JobType.values);
  static JsonTypeConverter2<ScheduleType, int, int> $converterscheduleType =
      const EnumIndexConverter<ScheduleType>(ScheduleType.values);
  static JsonTypeConverter2<BackupStrategy, int, int> $converterbackupStrategy =
      const EnumIndexConverter<BackupStrategy>(BackupStrategy.values);
  static JsonTypeConverter2<ComparisonMethod, int, int>
  $convertercomparisonMethod = const EnumIndexConverter<ComparisonMethod>(
    ComparisonMethod.values,
  );
  static JsonTypeConverter2<ChangePolicy, int, int> $converterchangePolicy =
      const EnumIndexConverter<ChangePolicy>(ChangePolicy.values);
  static JsonTypeConverter2<ChangePolicy?, int?, int?> $converterchangePolicyn =
      JsonTypeConverter2.asNullable($converterchangePolicy);
  static JsonTypeConverter2<CompressionType, int, int>
  $convertercompressionType = const EnumIndexConverter<CompressionType>(
    CompressionType.values,
  );
}

class Job extends DataClass implements Insertable<Job> {
  final int id;
  final String name;
  final JobType jobType;
  final String sourcePath;
  final String destinationNasPath;
  final ScheduleType scheduleType;
  final String? scheduleConfig;
  final BackupStrategy backupStrategy;
  final DateTime? fromDate;
  final ComparisonMethod comparisonMethod;
  final ChangePolicy? changePolicy;
  final CompressionType compressionType;
  final int? retentionCount;
  final int? retentionDays;
  final bool isEnabled;
  final DateTime createdAt;
  final DateTime? lastRunAt;
  final String? lastRunStatus;
  const Job({
    required this.id,
    required this.name,
    required this.jobType,
    required this.sourcePath,
    required this.destinationNasPath,
    required this.scheduleType,
    this.scheduleConfig,
    required this.backupStrategy,
    this.fromDate,
    required this.comparisonMethod,
    this.changePolicy,
    required this.compressionType,
    this.retentionCount,
    this.retentionDays,
    required this.isEnabled,
    required this.createdAt,
    this.lastRunAt,
    this.lastRunStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    {
      map['job_type'] = Variable<int>(
        $JobsTable.$converterjobType.toSql(jobType),
      );
    }
    map['source_path'] = Variable<String>(sourcePath);
    map['destination_nas_path'] = Variable<String>(destinationNasPath);
    {
      map['schedule_type'] = Variable<int>(
        $JobsTable.$converterscheduleType.toSql(scheduleType),
      );
    }
    if (!nullToAbsent || scheduleConfig != null) {
      map['schedule_config'] = Variable<String>(scheduleConfig);
    }
    {
      map['backup_strategy'] = Variable<int>(
        $JobsTable.$converterbackupStrategy.toSql(backupStrategy),
      );
    }
    if (!nullToAbsent || fromDate != null) {
      map['from_date'] = Variable<DateTime>(fromDate);
    }
    {
      map['comparison_method'] = Variable<int>(
        $JobsTable.$convertercomparisonMethod.toSql(comparisonMethod),
      );
    }
    if (!nullToAbsent || changePolicy != null) {
      map['change_policy'] = Variable<int>(
        $JobsTable.$converterchangePolicyn.toSql(changePolicy),
      );
    }
    {
      map['compression_type'] = Variable<int>(
        $JobsTable.$convertercompressionType.toSql(compressionType),
      );
    }
    if (!nullToAbsent || retentionCount != null) {
      map['retention_count'] = Variable<int>(retentionCount);
    }
    if (!nullToAbsent || retentionDays != null) {
      map['retention_days'] = Variable<int>(retentionDays);
    }
    map['is_enabled'] = Variable<bool>(isEnabled);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastRunAt != null) {
      map['last_run_at'] = Variable<DateTime>(lastRunAt);
    }
    if (!nullToAbsent || lastRunStatus != null) {
      map['last_run_status'] = Variable<String>(lastRunStatus);
    }
    return map;
  }

  JobsCompanion toCompanion(bool nullToAbsent) {
    return JobsCompanion(
      id: Value(id),
      name: Value(name),
      jobType: Value(jobType),
      sourcePath: Value(sourcePath),
      destinationNasPath: Value(destinationNasPath),
      scheduleType: Value(scheduleType),
      scheduleConfig: scheduleConfig == null && nullToAbsent
          ? const Value.absent()
          : Value(scheduleConfig),
      backupStrategy: Value(backupStrategy),
      fromDate: fromDate == null && nullToAbsent
          ? const Value.absent()
          : Value(fromDate),
      comparisonMethod: Value(comparisonMethod),
      changePolicy: changePolicy == null && nullToAbsent
          ? const Value.absent()
          : Value(changePolicy),
      compressionType: Value(compressionType),
      retentionCount: retentionCount == null && nullToAbsent
          ? const Value.absent()
          : Value(retentionCount),
      retentionDays: retentionDays == null && nullToAbsent
          ? const Value.absent()
          : Value(retentionDays),
      isEnabled: Value(isEnabled),
      createdAt: Value(createdAt),
      lastRunAt: lastRunAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastRunAt),
      lastRunStatus: lastRunStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(lastRunStatus),
    );
  }

  factory Job.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Job(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      jobType: $JobsTable.$converterjobType.fromJson(
        serializer.fromJson<int>(json['jobType']),
      ),
      sourcePath: serializer.fromJson<String>(json['sourcePath']),
      destinationNasPath: serializer.fromJson<String>(
        json['destinationNasPath'],
      ),
      scheduleType: $JobsTable.$converterscheduleType.fromJson(
        serializer.fromJson<int>(json['scheduleType']),
      ),
      scheduleConfig: serializer.fromJson<String?>(json['scheduleConfig']),
      backupStrategy: $JobsTable.$converterbackupStrategy.fromJson(
        serializer.fromJson<int>(json['backupStrategy']),
      ),
      fromDate: serializer.fromJson<DateTime?>(json['fromDate']),
      comparisonMethod: $JobsTable.$convertercomparisonMethod.fromJson(
        serializer.fromJson<int>(json['comparisonMethod']),
      ),
      changePolicy: $JobsTable.$converterchangePolicyn.fromJson(
        serializer.fromJson<int?>(json['changePolicy']),
      ),
      compressionType: $JobsTable.$convertercompressionType.fromJson(
        serializer.fromJson<int>(json['compressionType']),
      ),
      retentionCount: serializer.fromJson<int?>(json['retentionCount']),
      retentionDays: serializer.fromJson<int?>(json['retentionDays']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastRunAt: serializer.fromJson<DateTime?>(json['lastRunAt']),
      lastRunStatus: serializer.fromJson<String?>(json['lastRunStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'jobType': serializer.toJson<int>(
        $JobsTable.$converterjobType.toJson(jobType),
      ),
      'sourcePath': serializer.toJson<String>(sourcePath),
      'destinationNasPath': serializer.toJson<String>(destinationNasPath),
      'scheduleType': serializer.toJson<int>(
        $JobsTable.$converterscheduleType.toJson(scheduleType),
      ),
      'scheduleConfig': serializer.toJson<String?>(scheduleConfig),
      'backupStrategy': serializer.toJson<int>(
        $JobsTable.$converterbackupStrategy.toJson(backupStrategy),
      ),
      'fromDate': serializer.toJson<DateTime?>(fromDate),
      'comparisonMethod': serializer.toJson<int>(
        $JobsTable.$convertercomparisonMethod.toJson(comparisonMethod),
      ),
      'changePolicy': serializer.toJson<int?>(
        $JobsTable.$converterchangePolicyn.toJson(changePolicy),
      ),
      'compressionType': serializer.toJson<int>(
        $JobsTable.$convertercompressionType.toJson(compressionType),
      ),
      'retentionCount': serializer.toJson<int?>(retentionCount),
      'retentionDays': serializer.toJson<int?>(retentionDays),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastRunAt': serializer.toJson<DateTime?>(lastRunAt),
      'lastRunStatus': serializer.toJson<String?>(lastRunStatus),
    };
  }

  Job copyWith({
    int? id,
    String? name,
    JobType? jobType,
    String? sourcePath,
    String? destinationNasPath,
    ScheduleType? scheduleType,
    Value<String?> scheduleConfig = const Value.absent(),
    BackupStrategy? backupStrategy,
    Value<DateTime?> fromDate = const Value.absent(),
    ComparisonMethod? comparisonMethod,
    Value<ChangePolicy?> changePolicy = const Value.absent(),
    CompressionType? compressionType,
    Value<int?> retentionCount = const Value.absent(),
    Value<int?> retentionDays = const Value.absent(),
    bool? isEnabled,
    DateTime? createdAt,
    Value<DateTime?> lastRunAt = const Value.absent(),
    Value<String?> lastRunStatus = const Value.absent(),
  }) => Job(
    id: id ?? this.id,
    name: name ?? this.name,
    jobType: jobType ?? this.jobType,
    sourcePath: sourcePath ?? this.sourcePath,
    destinationNasPath: destinationNasPath ?? this.destinationNasPath,
    scheduleType: scheduleType ?? this.scheduleType,
    scheduleConfig: scheduleConfig.present
        ? scheduleConfig.value
        : this.scheduleConfig,
    backupStrategy: backupStrategy ?? this.backupStrategy,
    fromDate: fromDate.present ? fromDate.value : this.fromDate,
    comparisonMethod: comparisonMethod ?? this.comparisonMethod,
    changePolicy: changePolicy.present ? changePolicy.value : this.changePolicy,
    compressionType: compressionType ?? this.compressionType,
    retentionCount: retentionCount.present
        ? retentionCount.value
        : this.retentionCount,
    retentionDays: retentionDays.present
        ? retentionDays.value
        : this.retentionDays,
    isEnabled: isEnabled ?? this.isEnabled,
    createdAt: createdAt ?? this.createdAt,
    lastRunAt: lastRunAt.present ? lastRunAt.value : this.lastRunAt,
    lastRunStatus: lastRunStatus.present
        ? lastRunStatus.value
        : this.lastRunStatus,
  );
  Job copyWithCompanion(JobsCompanion data) {
    return Job(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      jobType: data.jobType.present ? data.jobType.value : this.jobType,
      sourcePath: data.sourcePath.present
          ? data.sourcePath.value
          : this.sourcePath,
      destinationNasPath: data.destinationNasPath.present
          ? data.destinationNasPath.value
          : this.destinationNasPath,
      scheduleType: data.scheduleType.present
          ? data.scheduleType.value
          : this.scheduleType,
      scheduleConfig: data.scheduleConfig.present
          ? data.scheduleConfig.value
          : this.scheduleConfig,
      backupStrategy: data.backupStrategy.present
          ? data.backupStrategy.value
          : this.backupStrategy,
      fromDate: data.fromDate.present ? data.fromDate.value : this.fromDate,
      comparisonMethod: data.comparisonMethod.present
          ? data.comparisonMethod.value
          : this.comparisonMethod,
      changePolicy: data.changePolicy.present
          ? data.changePolicy.value
          : this.changePolicy,
      compressionType: data.compressionType.present
          ? data.compressionType.value
          : this.compressionType,
      retentionCount: data.retentionCount.present
          ? data.retentionCount.value
          : this.retentionCount,
      retentionDays: data.retentionDays.present
          ? data.retentionDays.value
          : this.retentionDays,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastRunAt: data.lastRunAt.present ? data.lastRunAt.value : this.lastRunAt,
      lastRunStatus: data.lastRunStatus.present
          ? data.lastRunStatus.value
          : this.lastRunStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Job(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('jobType: $jobType, ')
          ..write('sourcePath: $sourcePath, ')
          ..write('destinationNasPath: $destinationNasPath, ')
          ..write('scheduleType: $scheduleType, ')
          ..write('scheduleConfig: $scheduleConfig, ')
          ..write('backupStrategy: $backupStrategy, ')
          ..write('fromDate: $fromDate, ')
          ..write('comparisonMethod: $comparisonMethod, ')
          ..write('changePolicy: $changePolicy, ')
          ..write('compressionType: $compressionType, ')
          ..write('retentionCount: $retentionCount, ')
          ..write('retentionDays: $retentionDays, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastRunAt: $lastRunAt, ')
          ..write('lastRunStatus: $lastRunStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    jobType,
    sourcePath,
    destinationNasPath,
    scheduleType,
    scheduleConfig,
    backupStrategy,
    fromDate,
    comparisonMethod,
    changePolicy,
    compressionType,
    retentionCount,
    retentionDays,
    isEnabled,
    createdAt,
    lastRunAt,
    lastRunStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Job &&
          other.id == this.id &&
          other.name == this.name &&
          other.jobType == this.jobType &&
          other.sourcePath == this.sourcePath &&
          other.destinationNasPath == this.destinationNasPath &&
          other.scheduleType == this.scheduleType &&
          other.scheduleConfig == this.scheduleConfig &&
          other.backupStrategy == this.backupStrategy &&
          other.fromDate == this.fromDate &&
          other.comparisonMethod == this.comparisonMethod &&
          other.changePolicy == this.changePolicy &&
          other.compressionType == this.compressionType &&
          other.retentionCount == this.retentionCount &&
          other.retentionDays == this.retentionDays &&
          other.isEnabled == this.isEnabled &&
          other.createdAt == this.createdAt &&
          other.lastRunAt == this.lastRunAt &&
          other.lastRunStatus == this.lastRunStatus);
}

class JobsCompanion extends UpdateCompanion<Job> {
  final Value<int> id;
  final Value<String> name;
  final Value<JobType> jobType;
  final Value<String> sourcePath;
  final Value<String> destinationNasPath;
  final Value<ScheduleType> scheduleType;
  final Value<String?> scheduleConfig;
  final Value<BackupStrategy> backupStrategy;
  final Value<DateTime?> fromDate;
  final Value<ComparisonMethod> comparisonMethod;
  final Value<ChangePolicy?> changePolicy;
  final Value<CompressionType> compressionType;
  final Value<int?> retentionCount;
  final Value<int?> retentionDays;
  final Value<bool> isEnabled;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastRunAt;
  final Value<String?> lastRunStatus;
  const JobsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.jobType = const Value.absent(),
    this.sourcePath = const Value.absent(),
    this.destinationNasPath = const Value.absent(),
    this.scheduleType = const Value.absent(),
    this.scheduleConfig = const Value.absent(),
    this.backupStrategy = const Value.absent(),
    this.fromDate = const Value.absent(),
    this.comparisonMethod = const Value.absent(),
    this.changePolicy = const Value.absent(),
    this.compressionType = const Value.absent(),
    this.retentionCount = const Value.absent(),
    this.retentionDays = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastRunAt = const Value.absent(),
    this.lastRunStatus = const Value.absent(),
  });
  JobsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required JobType jobType,
    required String sourcePath,
    required String destinationNasPath,
    required ScheduleType scheduleType,
    this.scheduleConfig = const Value.absent(),
    required BackupStrategy backupStrategy,
    this.fromDate = const Value.absent(),
    required ComparisonMethod comparisonMethod,
    this.changePolicy = const Value.absent(),
    required CompressionType compressionType,
    this.retentionCount = const Value.absent(),
    this.retentionDays = const Value.absent(),
    this.isEnabled = const Value.absent(),
    required DateTime createdAt,
    this.lastRunAt = const Value.absent(),
    this.lastRunStatus = const Value.absent(),
  }) : name = Value(name),
       jobType = Value(jobType),
       sourcePath = Value(sourcePath),
       destinationNasPath = Value(destinationNasPath),
       scheduleType = Value(scheduleType),
       backupStrategy = Value(backupStrategy),
       comparisonMethod = Value(comparisonMethod),
       compressionType = Value(compressionType),
       createdAt = Value(createdAt);
  static Insertable<Job> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? jobType,
    Expression<String>? sourcePath,
    Expression<String>? destinationNasPath,
    Expression<int>? scheduleType,
    Expression<String>? scheduleConfig,
    Expression<int>? backupStrategy,
    Expression<DateTime>? fromDate,
    Expression<int>? comparisonMethod,
    Expression<int>? changePolicy,
    Expression<int>? compressionType,
    Expression<int>? retentionCount,
    Expression<int>? retentionDays,
    Expression<bool>? isEnabled,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastRunAt,
    Expression<String>? lastRunStatus,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (jobType != null) 'job_type': jobType,
      if (sourcePath != null) 'source_path': sourcePath,
      if (destinationNasPath != null)
        'destination_nas_path': destinationNasPath,
      if (scheduleType != null) 'schedule_type': scheduleType,
      if (scheduleConfig != null) 'schedule_config': scheduleConfig,
      if (backupStrategy != null) 'backup_strategy': backupStrategy,
      if (fromDate != null) 'from_date': fromDate,
      if (comparisonMethod != null) 'comparison_method': comparisonMethod,
      if (changePolicy != null) 'change_policy': changePolicy,
      if (compressionType != null) 'compression_type': compressionType,
      if (retentionCount != null) 'retention_count': retentionCount,
      if (retentionDays != null) 'retention_days': retentionDays,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (createdAt != null) 'created_at': createdAt,
      if (lastRunAt != null) 'last_run_at': lastRunAt,
      if (lastRunStatus != null) 'last_run_status': lastRunStatus,
    });
  }

  JobsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<JobType>? jobType,
    Value<String>? sourcePath,
    Value<String>? destinationNasPath,
    Value<ScheduleType>? scheduleType,
    Value<String?>? scheduleConfig,
    Value<BackupStrategy>? backupStrategy,
    Value<DateTime?>? fromDate,
    Value<ComparisonMethod>? comparisonMethod,
    Value<ChangePolicy?>? changePolicy,
    Value<CompressionType>? compressionType,
    Value<int?>? retentionCount,
    Value<int?>? retentionDays,
    Value<bool>? isEnabled,
    Value<DateTime>? createdAt,
    Value<DateTime?>? lastRunAt,
    Value<String?>? lastRunStatus,
  }) {
    return JobsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      jobType: jobType ?? this.jobType,
      sourcePath: sourcePath ?? this.sourcePath,
      destinationNasPath: destinationNasPath ?? this.destinationNasPath,
      scheduleType: scheduleType ?? this.scheduleType,
      scheduleConfig: scheduleConfig ?? this.scheduleConfig,
      backupStrategy: backupStrategy ?? this.backupStrategy,
      fromDate: fromDate ?? this.fromDate,
      comparisonMethod: comparisonMethod ?? this.comparisonMethod,
      changePolicy: changePolicy ?? this.changePolicy,
      compressionType: compressionType ?? this.compressionType,
      retentionCount: retentionCount ?? this.retentionCount,
      retentionDays: retentionDays ?? this.retentionDays,
      isEnabled: isEnabled ?? this.isEnabled,
      createdAt: createdAt ?? this.createdAt,
      lastRunAt: lastRunAt ?? this.lastRunAt,
      lastRunStatus: lastRunStatus ?? this.lastRunStatus,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (jobType.present) {
      map['job_type'] = Variable<int>(
        $JobsTable.$converterjobType.toSql(jobType.value),
      );
    }
    if (sourcePath.present) {
      map['source_path'] = Variable<String>(sourcePath.value);
    }
    if (destinationNasPath.present) {
      map['destination_nas_path'] = Variable<String>(destinationNasPath.value);
    }
    if (scheduleType.present) {
      map['schedule_type'] = Variable<int>(
        $JobsTable.$converterscheduleType.toSql(scheduleType.value),
      );
    }
    if (scheduleConfig.present) {
      map['schedule_config'] = Variable<String>(scheduleConfig.value);
    }
    if (backupStrategy.present) {
      map['backup_strategy'] = Variable<int>(
        $JobsTable.$converterbackupStrategy.toSql(backupStrategy.value),
      );
    }
    if (fromDate.present) {
      map['from_date'] = Variable<DateTime>(fromDate.value);
    }
    if (comparisonMethod.present) {
      map['comparison_method'] = Variable<int>(
        $JobsTable.$convertercomparisonMethod.toSql(comparisonMethod.value),
      );
    }
    if (changePolicy.present) {
      map['change_policy'] = Variable<int>(
        $JobsTable.$converterchangePolicyn.toSql(changePolicy.value),
      );
    }
    if (compressionType.present) {
      map['compression_type'] = Variable<int>(
        $JobsTable.$convertercompressionType.toSql(compressionType.value),
      );
    }
    if (retentionCount.present) {
      map['retention_count'] = Variable<int>(retentionCount.value);
    }
    if (retentionDays.present) {
      map['retention_days'] = Variable<int>(retentionDays.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastRunAt.present) {
      map['last_run_at'] = Variable<DateTime>(lastRunAt.value);
    }
    if (lastRunStatus.present) {
      map['last_run_status'] = Variable<String>(lastRunStatus.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JobsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('jobType: $jobType, ')
          ..write('sourcePath: $sourcePath, ')
          ..write('destinationNasPath: $destinationNasPath, ')
          ..write('scheduleType: $scheduleType, ')
          ..write('scheduleConfig: $scheduleConfig, ')
          ..write('backupStrategy: $backupStrategy, ')
          ..write('fromDate: $fromDate, ')
          ..write('comparisonMethod: $comparisonMethod, ')
          ..write('changePolicy: $changePolicy, ')
          ..write('compressionType: $compressionType, ')
          ..write('retentionCount: $retentionCount, ')
          ..write('retentionDays: $retentionDays, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastRunAt: $lastRunAt, ')
          ..write('lastRunStatus: $lastRunStatus')
          ..write(')'))
        .toString();
  }
}

class $JobRunsTable extends JobRuns with TableInfo<$JobRunsTable, JobRun> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JobRunsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _jobIdMeta = const VerificationMeta('jobId');
  @override
  late final GeneratedColumn<int> jobId = GeneratedColumn<int>(
    'job_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES jobs (id)',
    ),
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<RunStatus, int> status =
      GeneratedColumn<int>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<RunStatus>($JobRunsTable.$converterstatus);
  static const VerificationMeta _filesScannedMeta = const VerificationMeta(
    'filesScanned',
  );
  @override
  late final GeneratedColumn<int> filesScanned = GeneratedColumn<int>(
    'files_scanned',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _filesUploadedMeta = const VerificationMeta(
    'filesUploaded',
  );
  @override
  late final GeneratedColumn<int> filesUploaded = GeneratedColumn<int>(
    'files_uploaded',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _filesSkippedMeta = const VerificationMeta(
    'filesSkipped',
  );
  @override
  late final GeneratedColumn<int> filesSkipped = GeneratedColumn<int>(
    'files_skipped',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _filesFailedMeta = const VerificationMeta(
    'filesFailed',
  );
  @override
  late final GeneratedColumn<int> filesFailed = GeneratedColumn<int>(
    'files_failed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _bytesTransferredMeta = const VerificationMeta(
    'bytesTransferred',
  );
  @override
  late final GeneratedColumn<int> bytesTransferred = GeneratedColumn<int>(
    'bytes_transferred',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _errorSummaryMeta = const VerificationMeta(
    'errorSummary',
  );
  @override
  late final GeneratedColumn<String> errorSummary = GeneratedColumn<String>(
    'error_summary',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    jobId,
    startedAt,
    completedAt,
    status,
    filesScanned,
    filesUploaded,
    filesSkipped,
    filesFailed,
    bytesTransferred,
    errorSummary,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'job_runs';
  @override
  VerificationContext validateIntegrity(
    Insertable<JobRun> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('job_id')) {
      context.handle(
        _jobIdMeta,
        jobId.isAcceptableOrUnknown(data['job_id']!, _jobIdMeta),
      );
    } else if (isInserting) {
      context.missing(_jobIdMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('files_scanned')) {
      context.handle(
        _filesScannedMeta,
        filesScanned.isAcceptableOrUnknown(
          data['files_scanned']!,
          _filesScannedMeta,
        ),
      );
    }
    if (data.containsKey('files_uploaded')) {
      context.handle(
        _filesUploadedMeta,
        filesUploaded.isAcceptableOrUnknown(
          data['files_uploaded']!,
          _filesUploadedMeta,
        ),
      );
    }
    if (data.containsKey('files_skipped')) {
      context.handle(
        _filesSkippedMeta,
        filesSkipped.isAcceptableOrUnknown(
          data['files_skipped']!,
          _filesSkippedMeta,
        ),
      );
    }
    if (data.containsKey('files_failed')) {
      context.handle(
        _filesFailedMeta,
        filesFailed.isAcceptableOrUnknown(
          data['files_failed']!,
          _filesFailedMeta,
        ),
      );
    }
    if (data.containsKey('bytes_transferred')) {
      context.handle(
        _bytesTransferredMeta,
        bytesTransferred.isAcceptableOrUnknown(
          data['bytes_transferred']!,
          _bytesTransferredMeta,
        ),
      );
    }
    if (data.containsKey('error_summary')) {
      context.handle(
        _errorSummaryMeta,
        errorSummary.isAcceptableOrUnknown(
          data['error_summary']!,
          _errorSummaryMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JobRun map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JobRun(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      jobId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}job_id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      status: $JobRunsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}status'],
        )!,
      ),
      filesScanned: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}files_scanned'],
      )!,
      filesUploaded: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}files_uploaded'],
      )!,
      filesSkipped: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}files_skipped'],
      )!,
      filesFailed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}files_failed'],
      )!,
      bytesTransferred: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bytes_transferred'],
      )!,
      errorSummary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_summary'],
      ),
    );
  }

  @override
  $JobRunsTable createAlias(String alias) {
    return $JobRunsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<RunStatus, int, int> $converterstatus =
      const EnumIndexConverter<RunStatus>(RunStatus.values);
}

class JobRun extends DataClass implements Insertable<JobRun> {
  final int id;
  final int jobId;
  final DateTime startedAt;
  final DateTime? completedAt;
  final RunStatus status;
  final int filesScanned;
  final int filesUploaded;
  final int filesSkipped;
  final int filesFailed;
  final int bytesTransferred;
  final String? errorSummary;
  const JobRun({
    required this.id,
    required this.jobId,
    required this.startedAt,
    this.completedAt,
    required this.status,
    required this.filesScanned,
    required this.filesUploaded,
    required this.filesSkipped,
    required this.filesFailed,
    required this.bytesTransferred,
    this.errorSummary,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['job_id'] = Variable<int>(jobId);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    {
      map['status'] = Variable<int>(
        $JobRunsTable.$converterstatus.toSql(status),
      );
    }
    map['files_scanned'] = Variable<int>(filesScanned);
    map['files_uploaded'] = Variable<int>(filesUploaded);
    map['files_skipped'] = Variable<int>(filesSkipped);
    map['files_failed'] = Variable<int>(filesFailed);
    map['bytes_transferred'] = Variable<int>(bytesTransferred);
    if (!nullToAbsent || errorSummary != null) {
      map['error_summary'] = Variable<String>(errorSummary);
    }
    return map;
  }

  JobRunsCompanion toCompanion(bool nullToAbsent) {
    return JobRunsCompanion(
      id: Value(id),
      jobId: Value(jobId),
      startedAt: Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      status: Value(status),
      filesScanned: Value(filesScanned),
      filesUploaded: Value(filesUploaded),
      filesSkipped: Value(filesSkipped),
      filesFailed: Value(filesFailed),
      bytesTransferred: Value(bytesTransferred),
      errorSummary: errorSummary == null && nullToAbsent
          ? const Value.absent()
          : Value(errorSummary),
    );
  }

  factory JobRun.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JobRun(
      id: serializer.fromJson<int>(json['id']),
      jobId: serializer.fromJson<int>(json['jobId']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      status: $JobRunsTable.$converterstatus.fromJson(
        serializer.fromJson<int>(json['status']),
      ),
      filesScanned: serializer.fromJson<int>(json['filesScanned']),
      filesUploaded: serializer.fromJson<int>(json['filesUploaded']),
      filesSkipped: serializer.fromJson<int>(json['filesSkipped']),
      filesFailed: serializer.fromJson<int>(json['filesFailed']),
      bytesTransferred: serializer.fromJson<int>(json['bytesTransferred']),
      errorSummary: serializer.fromJson<String?>(json['errorSummary']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'jobId': serializer.toJson<int>(jobId),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'status': serializer.toJson<int>(
        $JobRunsTable.$converterstatus.toJson(status),
      ),
      'filesScanned': serializer.toJson<int>(filesScanned),
      'filesUploaded': serializer.toJson<int>(filesUploaded),
      'filesSkipped': serializer.toJson<int>(filesSkipped),
      'filesFailed': serializer.toJson<int>(filesFailed),
      'bytesTransferred': serializer.toJson<int>(bytesTransferred),
      'errorSummary': serializer.toJson<String?>(errorSummary),
    };
  }

  JobRun copyWith({
    int? id,
    int? jobId,
    DateTime? startedAt,
    Value<DateTime?> completedAt = const Value.absent(),
    RunStatus? status,
    int? filesScanned,
    int? filesUploaded,
    int? filesSkipped,
    int? filesFailed,
    int? bytesTransferred,
    Value<String?> errorSummary = const Value.absent(),
  }) => JobRun(
    id: id ?? this.id,
    jobId: jobId ?? this.jobId,
    startedAt: startedAt ?? this.startedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    status: status ?? this.status,
    filesScanned: filesScanned ?? this.filesScanned,
    filesUploaded: filesUploaded ?? this.filesUploaded,
    filesSkipped: filesSkipped ?? this.filesSkipped,
    filesFailed: filesFailed ?? this.filesFailed,
    bytesTransferred: bytesTransferred ?? this.bytesTransferred,
    errorSummary: errorSummary.present ? errorSummary.value : this.errorSummary,
  );
  JobRun copyWithCompanion(JobRunsCompanion data) {
    return JobRun(
      id: data.id.present ? data.id.value : this.id,
      jobId: data.jobId.present ? data.jobId.value : this.jobId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      status: data.status.present ? data.status.value : this.status,
      filesScanned: data.filesScanned.present
          ? data.filesScanned.value
          : this.filesScanned,
      filesUploaded: data.filesUploaded.present
          ? data.filesUploaded.value
          : this.filesUploaded,
      filesSkipped: data.filesSkipped.present
          ? data.filesSkipped.value
          : this.filesSkipped,
      filesFailed: data.filesFailed.present
          ? data.filesFailed.value
          : this.filesFailed,
      bytesTransferred: data.bytesTransferred.present
          ? data.bytesTransferred.value
          : this.bytesTransferred,
      errorSummary: data.errorSummary.present
          ? data.errorSummary.value
          : this.errorSummary,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JobRun(')
          ..write('id: $id, ')
          ..write('jobId: $jobId, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('status: $status, ')
          ..write('filesScanned: $filesScanned, ')
          ..write('filesUploaded: $filesUploaded, ')
          ..write('filesSkipped: $filesSkipped, ')
          ..write('filesFailed: $filesFailed, ')
          ..write('bytesTransferred: $bytesTransferred, ')
          ..write('errorSummary: $errorSummary')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    jobId,
    startedAt,
    completedAt,
    status,
    filesScanned,
    filesUploaded,
    filesSkipped,
    filesFailed,
    bytesTransferred,
    errorSummary,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JobRun &&
          other.id == this.id &&
          other.jobId == this.jobId &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.status == this.status &&
          other.filesScanned == this.filesScanned &&
          other.filesUploaded == this.filesUploaded &&
          other.filesSkipped == this.filesSkipped &&
          other.filesFailed == this.filesFailed &&
          other.bytesTransferred == this.bytesTransferred &&
          other.errorSummary == this.errorSummary);
}

class JobRunsCompanion extends UpdateCompanion<JobRun> {
  final Value<int> id;
  final Value<int> jobId;
  final Value<DateTime> startedAt;
  final Value<DateTime?> completedAt;
  final Value<RunStatus> status;
  final Value<int> filesScanned;
  final Value<int> filesUploaded;
  final Value<int> filesSkipped;
  final Value<int> filesFailed;
  final Value<int> bytesTransferred;
  final Value<String?> errorSummary;
  const JobRunsCompanion({
    this.id = const Value.absent(),
    this.jobId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.filesScanned = const Value.absent(),
    this.filesUploaded = const Value.absent(),
    this.filesSkipped = const Value.absent(),
    this.filesFailed = const Value.absent(),
    this.bytesTransferred = const Value.absent(),
    this.errorSummary = const Value.absent(),
  });
  JobRunsCompanion.insert({
    this.id = const Value.absent(),
    required int jobId,
    required DateTime startedAt,
    this.completedAt = const Value.absent(),
    required RunStatus status,
    this.filesScanned = const Value.absent(),
    this.filesUploaded = const Value.absent(),
    this.filesSkipped = const Value.absent(),
    this.filesFailed = const Value.absent(),
    this.bytesTransferred = const Value.absent(),
    this.errorSummary = const Value.absent(),
  }) : jobId = Value(jobId),
       startedAt = Value(startedAt),
       status = Value(status);
  static Insertable<JobRun> custom({
    Expression<int>? id,
    Expression<int>? jobId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<int>? status,
    Expression<int>? filesScanned,
    Expression<int>? filesUploaded,
    Expression<int>? filesSkipped,
    Expression<int>? filesFailed,
    Expression<int>? bytesTransferred,
    Expression<String>? errorSummary,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (jobId != null) 'job_id': jobId,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (status != null) 'status': status,
      if (filesScanned != null) 'files_scanned': filesScanned,
      if (filesUploaded != null) 'files_uploaded': filesUploaded,
      if (filesSkipped != null) 'files_skipped': filesSkipped,
      if (filesFailed != null) 'files_failed': filesFailed,
      if (bytesTransferred != null) 'bytes_transferred': bytesTransferred,
      if (errorSummary != null) 'error_summary': errorSummary,
    });
  }

  JobRunsCompanion copyWith({
    Value<int>? id,
    Value<int>? jobId,
    Value<DateTime>? startedAt,
    Value<DateTime?>? completedAt,
    Value<RunStatus>? status,
    Value<int>? filesScanned,
    Value<int>? filesUploaded,
    Value<int>? filesSkipped,
    Value<int>? filesFailed,
    Value<int>? bytesTransferred,
    Value<String?>? errorSummary,
  }) {
    return JobRunsCompanion(
      id: id ?? this.id,
      jobId: jobId ?? this.jobId,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      status: status ?? this.status,
      filesScanned: filesScanned ?? this.filesScanned,
      filesUploaded: filesUploaded ?? this.filesUploaded,
      filesSkipped: filesSkipped ?? this.filesSkipped,
      filesFailed: filesFailed ?? this.filesFailed,
      bytesTransferred: bytesTransferred ?? this.bytesTransferred,
      errorSummary: errorSummary ?? this.errorSummary,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (jobId.present) {
      map['job_id'] = Variable<int>(jobId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(
        $JobRunsTable.$converterstatus.toSql(status.value),
      );
    }
    if (filesScanned.present) {
      map['files_scanned'] = Variable<int>(filesScanned.value);
    }
    if (filesUploaded.present) {
      map['files_uploaded'] = Variable<int>(filesUploaded.value);
    }
    if (filesSkipped.present) {
      map['files_skipped'] = Variable<int>(filesSkipped.value);
    }
    if (filesFailed.present) {
      map['files_failed'] = Variable<int>(filesFailed.value);
    }
    if (bytesTransferred.present) {
      map['bytes_transferred'] = Variable<int>(bytesTransferred.value);
    }
    if (errorSummary.present) {
      map['error_summary'] = Variable<String>(errorSummary.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JobRunsCompanion(')
          ..write('id: $id, ')
          ..write('jobId: $jobId, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('status: $status, ')
          ..write('filesScanned: $filesScanned, ')
          ..write('filesUploaded: $filesUploaded, ')
          ..write('filesSkipped: $filesSkipped, ')
          ..write('filesFailed: $filesFailed, ')
          ..write('bytesTransferred: $bytesTransferred, ')
          ..write('errorSummary: $errorSummary')
          ..write(')'))
        .toString();
  }
}

class $FileRecordsTable extends FileRecords
    with TableInfo<$FileRecordsTable, FileRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FileRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _jobIdMeta = const VerificationMeta('jobId');
  @override
  late final GeneratedColumn<int> jobId = GeneratedColumn<int>(
    'job_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES jobs (id)',
    ),
  );
  static const VerificationMeta _relativePathMeta = const VerificationMeta(
    'relativePath',
  );
  @override
  late final GeneratedColumn<String> relativePath = GeneratedColumn<String>(
    'relative_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nasPathMeta = const VerificationMeta(
    'nasPath',
  );
  @override
  late final GeneratedColumn<String> nasPath = GeneratedColumn<String>(
    'nas_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sizeBytesMeta = const VerificationMeta(
    'sizeBytes',
  );
  @override
  late final GeneratedColumn<int> sizeBytes = GeneratedColumn<int>(
    'size_bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastModifiedMeta = const VerificationMeta(
    'lastModified',
  );
  @override
  late final GeneratedColumn<DateTime> lastModified = GeneratedColumn<DateTime>(
    'last_modified',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hashMeta = const VerificationMeta('hash');
  @override
  late final GeneratedColumn<String> hash = GeneratedColumn<String>(
    'hash',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastBackedUpAtMeta = const VerificationMeta(
    'lastBackedUpAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastBackedUpAt =
      GeneratedColumn<DateTime>(
        'last_backed_up_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<FileStatus, int> lastStatus =
      GeneratedColumn<int>(
        'last_status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<FileStatus>($FileRecordsTable.$converterlastStatus);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    jobId,
    relativePath,
    nasPath,
    sizeBytes,
    lastModified,
    hash,
    lastBackedUpAt,
    lastStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'file_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<FileRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('job_id')) {
      context.handle(
        _jobIdMeta,
        jobId.isAcceptableOrUnknown(data['job_id']!, _jobIdMeta),
      );
    } else if (isInserting) {
      context.missing(_jobIdMeta);
    }
    if (data.containsKey('relative_path')) {
      context.handle(
        _relativePathMeta,
        relativePath.isAcceptableOrUnknown(
          data['relative_path']!,
          _relativePathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_relativePathMeta);
    }
    if (data.containsKey('nas_path')) {
      context.handle(
        _nasPathMeta,
        nasPath.isAcceptableOrUnknown(data['nas_path']!, _nasPathMeta),
      );
    } else if (isInserting) {
      context.missing(_nasPathMeta);
    }
    if (data.containsKey('size_bytes')) {
      context.handle(
        _sizeBytesMeta,
        sizeBytes.isAcceptableOrUnknown(data['size_bytes']!, _sizeBytesMeta),
      );
    } else if (isInserting) {
      context.missing(_sizeBytesMeta);
    }
    if (data.containsKey('last_modified')) {
      context.handle(
        _lastModifiedMeta,
        lastModified.isAcceptableOrUnknown(
          data['last_modified']!,
          _lastModifiedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastModifiedMeta);
    }
    if (data.containsKey('hash')) {
      context.handle(
        _hashMeta,
        hash.isAcceptableOrUnknown(data['hash']!, _hashMeta),
      );
    }
    if (data.containsKey('last_backed_up_at')) {
      context.handle(
        _lastBackedUpAtMeta,
        lastBackedUpAt.isAcceptableOrUnknown(
          data['last_backed_up_at']!,
          _lastBackedUpAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FileRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FileRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      jobId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}job_id'],
      )!,
      relativePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relative_path'],
      )!,
      nasPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nas_path'],
      )!,
      sizeBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}size_bytes'],
      )!,
      lastModified: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_modified'],
      )!,
      hash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hash'],
      ),
      lastBackedUpAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_backed_up_at'],
      ),
      lastStatus: $FileRecordsTable.$converterlastStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}last_status'],
        )!,
      ),
    );
  }

  @override
  $FileRecordsTable createAlias(String alias) {
    return $FileRecordsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<FileStatus, int, int> $converterlastStatus =
      const EnumIndexConverter<FileStatus>(FileStatus.values);
}

class FileRecord extends DataClass implements Insertable<FileRecord> {
  final int id;
  final int jobId;
  final String relativePath;
  final String nasPath;
  final int sizeBytes;
  final DateTime lastModified;
  final String? hash;
  final DateTime? lastBackedUpAt;
  final FileStatus lastStatus;
  const FileRecord({
    required this.id,
    required this.jobId,
    required this.relativePath,
    required this.nasPath,
    required this.sizeBytes,
    required this.lastModified,
    this.hash,
    this.lastBackedUpAt,
    required this.lastStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['job_id'] = Variable<int>(jobId);
    map['relative_path'] = Variable<String>(relativePath);
    map['nas_path'] = Variable<String>(nasPath);
    map['size_bytes'] = Variable<int>(sizeBytes);
    map['last_modified'] = Variable<DateTime>(lastModified);
    if (!nullToAbsent || hash != null) {
      map['hash'] = Variable<String>(hash);
    }
    if (!nullToAbsent || lastBackedUpAt != null) {
      map['last_backed_up_at'] = Variable<DateTime>(lastBackedUpAt);
    }
    {
      map['last_status'] = Variable<int>(
        $FileRecordsTable.$converterlastStatus.toSql(lastStatus),
      );
    }
    return map;
  }

  FileRecordsCompanion toCompanion(bool nullToAbsent) {
    return FileRecordsCompanion(
      id: Value(id),
      jobId: Value(jobId),
      relativePath: Value(relativePath),
      nasPath: Value(nasPath),
      sizeBytes: Value(sizeBytes),
      lastModified: Value(lastModified),
      hash: hash == null && nullToAbsent ? const Value.absent() : Value(hash),
      lastBackedUpAt: lastBackedUpAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastBackedUpAt),
      lastStatus: Value(lastStatus),
    );
  }

  factory FileRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FileRecord(
      id: serializer.fromJson<int>(json['id']),
      jobId: serializer.fromJson<int>(json['jobId']),
      relativePath: serializer.fromJson<String>(json['relativePath']),
      nasPath: serializer.fromJson<String>(json['nasPath']),
      sizeBytes: serializer.fromJson<int>(json['sizeBytes']),
      lastModified: serializer.fromJson<DateTime>(json['lastModified']),
      hash: serializer.fromJson<String?>(json['hash']),
      lastBackedUpAt: serializer.fromJson<DateTime?>(json['lastBackedUpAt']),
      lastStatus: $FileRecordsTable.$converterlastStatus.fromJson(
        serializer.fromJson<int>(json['lastStatus']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'jobId': serializer.toJson<int>(jobId),
      'relativePath': serializer.toJson<String>(relativePath),
      'nasPath': serializer.toJson<String>(nasPath),
      'sizeBytes': serializer.toJson<int>(sizeBytes),
      'lastModified': serializer.toJson<DateTime>(lastModified),
      'hash': serializer.toJson<String?>(hash),
      'lastBackedUpAt': serializer.toJson<DateTime?>(lastBackedUpAt),
      'lastStatus': serializer.toJson<int>(
        $FileRecordsTable.$converterlastStatus.toJson(lastStatus),
      ),
    };
  }

  FileRecord copyWith({
    int? id,
    int? jobId,
    String? relativePath,
    String? nasPath,
    int? sizeBytes,
    DateTime? lastModified,
    Value<String?> hash = const Value.absent(),
    Value<DateTime?> lastBackedUpAt = const Value.absent(),
    FileStatus? lastStatus,
  }) => FileRecord(
    id: id ?? this.id,
    jobId: jobId ?? this.jobId,
    relativePath: relativePath ?? this.relativePath,
    nasPath: nasPath ?? this.nasPath,
    sizeBytes: sizeBytes ?? this.sizeBytes,
    lastModified: lastModified ?? this.lastModified,
    hash: hash.present ? hash.value : this.hash,
    lastBackedUpAt: lastBackedUpAt.present
        ? lastBackedUpAt.value
        : this.lastBackedUpAt,
    lastStatus: lastStatus ?? this.lastStatus,
  );
  FileRecord copyWithCompanion(FileRecordsCompanion data) {
    return FileRecord(
      id: data.id.present ? data.id.value : this.id,
      jobId: data.jobId.present ? data.jobId.value : this.jobId,
      relativePath: data.relativePath.present
          ? data.relativePath.value
          : this.relativePath,
      nasPath: data.nasPath.present ? data.nasPath.value : this.nasPath,
      sizeBytes: data.sizeBytes.present ? data.sizeBytes.value : this.sizeBytes,
      lastModified: data.lastModified.present
          ? data.lastModified.value
          : this.lastModified,
      hash: data.hash.present ? data.hash.value : this.hash,
      lastBackedUpAt: data.lastBackedUpAt.present
          ? data.lastBackedUpAt.value
          : this.lastBackedUpAt,
      lastStatus: data.lastStatus.present
          ? data.lastStatus.value
          : this.lastStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FileRecord(')
          ..write('id: $id, ')
          ..write('jobId: $jobId, ')
          ..write('relativePath: $relativePath, ')
          ..write('nasPath: $nasPath, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('lastModified: $lastModified, ')
          ..write('hash: $hash, ')
          ..write('lastBackedUpAt: $lastBackedUpAt, ')
          ..write('lastStatus: $lastStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    jobId,
    relativePath,
    nasPath,
    sizeBytes,
    lastModified,
    hash,
    lastBackedUpAt,
    lastStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FileRecord &&
          other.id == this.id &&
          other.jobId == this.jobId &&
          other.relativePath == this.relativePath &&
          other.nasPath == this.nasPath &&
          other.sizeBytes == this.sizeBytes &&
          other.lastModified == this.lastModified &&
          other.hash == this.hash &&
          other.lastBackedUpAt == this.lastBackedUpAt &&
          other.lastStatus == this.lastStatus);
}

class FileRecordsCompanion extends UpdateCompanion<FileRecord> {
  final Value<int> id;
  final Value<int> jobId;
  final Value<String> relativePath;
  final Value<String> nasPath;
  final Value<int> sizeBytes;
  final Value<DateTime> lastModified;
  final Value<String?> hash;
  final Value<DateTime?> lastBackedUpAt;
  final Value<FileStatus> lastStatus;
  const FileRecordsCompanion({
    this.id = const Value.absent(),
    this.jobId = const Value.absent(),
    this.relativePath = const Value.absent(),
    this.nasPath = const Value.absent(),
    this.sizeBytes = const Value.absent(),
    this.lastModified = const Value.absent(),
    this.hash = const Value.absent(),
    this.lastBackedUpAt = const Value.absent(),
    this.lastStatus = const Value.absent(),
  });
  FileRecordsCompanion.insert({
    this.id = const Value.absent(),
    required int jobId,
    required String relativePath,
    required String nasPath,
    required int sizeBytes,
    required DateTime lastModified,
    this.hash = const Value.absent(),
    this.lastBackedUpAt = const Value.absent(),
    required FileStatus lastStatus,
  }) : jobId = Value(jobId),
       relativePath = Value(relativePath),
       nasPath = Value(nasPath),
       sizeBytes = Value(sizeBytes),
       lastModified = Value(lastModified),
       lastStatus = Value(lastStatus);
  static Insertable<FileRecord> custom({
    Expression<int>? id,
    Expression<int>? jobId,
    Expression<String>? relativePath,
    Expression<String>? nasPath,
    Expression<int>? sizeBytes,
    Expression<DateTime>? lastModified,
    Expression<String>? hash,
    Expression<DateTime>? lastBackedUpAt,
    Expression<int>? lastStatus,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (jobId != null) 'job_id': jobId,
      if (relativePath != null) 'relative_path': relativePath,
      if (nasPath != null) 'nas_path': nasPath,
      if (sizeBytes != null) 'size_bytes': sizeBytes,
      if (lastModified != null) 'last_modified': lastModified,
      if (hash != null) 'hash': hash,
      if (lastBackedUpAt != null) 'last_backed_up_at': lastBackedUpAt,
      if (lastStatus != null) 'last_status': lastStatus,
    });
  }

  FileRecordsCompanion copyWith({
    Value<int>? id,
    Value<int>? jobId,
    Value<String>? relativePath,
    Value<String>? nasPath,
    Value<int>? sizeBytes,
    Value<DateTime>? lastModified,
    Value<String?>? hash,
    Value<DateTime?>? lastBackedUpAt,
    Value<FileStatus>? lastStatus,
  }) {
    return FileRecordsCompanion(
      id: id ?? this.id,
      jobId: jobId ?? this.jobId,
      relativePath: relativePath ?? this.relativePath,
      nasPath: nasPath ?? this.nasPath,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      lastModified: lastModified ?? this.lastModified,
      hash: hash ?? this.hash,
      lastBackedUpAt: lastBackedUpAt ?? this.lastBackedUpAt,
      lastStatus: lastStatus ?? this.lastStatus,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (jobId.present) {
      map['job_id'] = Variable<int>(jobId.value);
    }
    if (relativePath.present) {
      map['relative_path'] = Variable<String>(relativePath.value);
    }
    if (nasPath.present) {
      map['nas_path'] = Variable<String>(nasPath.value);
    }
    if (sizeBytes.present) {
      map['size_bytes'] = Variable<int>(sizeBytes.value);
    }
    if (lastModified.present) {
      map['last_modified'] = Variable<DateTime>(lastModified.value);
    }
    if (hash.present) {
      map['hash'] = Variable<String>(hash.value);
    }
    if (lastBackedUpAt.present) {
      map['last_backed_up_at'] = Variable<DateTime>(lastBackedUpAt.value);
    }
    if (lastStatus.present) {
      map['last_status'] = Variable<int>(
        $FileRecordsTable.$converterlastStatus.toSql(lastStatus.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FileRecordsCompanion(')
          ..write('id: $id, ')
          ..write('jobId: $jobId, ')
          ..write('relativePath: $relativePath, ')
          ..write('nasPath: $nasPath, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('lastModified: $lastModified, ')
          ..write('hash: $hash, ')
          ..write('lastBackedUpAt: $lastBackedUpAt, ')
          ..write('lastStatus: $lastStatus')
          ..write(')'))
        .toString();
  }
}

class $FileRunLogsTable extends FileRunLogs
    with TableInfo<$FileRunLogsTable, FileRunLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FileRunLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _runIdMeta = const VerificationMeta('runId');
  @override
  late final GeneratedColumn<int> runId = GeneratedColumn<int>(
    'run_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES job_runs (id)',
    ),
  );
  static const VerificationMeta _fileRecordIdMeta = const VerificationMeta(
    'fileRecordId',
  );
  @override
  late final GeneratedColumn<int> fileRecordId = GeneratedColumn<int>(
    'file_record_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES file_records (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<FileAction, int> action =
      GeneratedColumn<int>(
        'action',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<FileAction>($FileRunLogsTable.$converteraction);
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _errorMessageMeta = const VerificationMeta(
    'errorMessage',
  );
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
    'error_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    runId,
    fileRecordId,
    action,
    filePath,
    errorMessage,
    occurredAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'file_run_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<FileRunLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('run_id')) {
      context.handle(
        _runIdMeta,
        runId.isAcceptableOrUnknown(data['run_id']!, _runIdMeta),
      );
    } else if (isInserting) {
      context.missing(_runIdMeta);
    }
    if (data.containsKey('file_record_id')) {
      context.handle(
        _fileRecordIdMeta,
        fileRecordId.isAcceptableOrUnknown(
          data['file_record_id']!,
          _fileRecordIdMeta,
        ),
      );
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('error_message')) {
      context.handle(
        _errorMessageMeta,
        errorMessage.isAcceptableOrUnknown(
          data['error_message']!,
          _errorMessageMeta,
        ),
      );
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FileRunLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FileRunLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      runId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}run_id'],
      )!,
      fileRecordId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}file_record_id'],
      ),
      action: $FileRunLogsTable.$converteraction.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}action'],
        )!,
      ),
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      )!,
      errorMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_message'],
      ),
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
    );
  }

  @override
  $FileRunLogsTable createAlias(String alias) {
    return $FileRunLogsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<FileAction, int, int> $converteraction =
      const EnumIndexConverter<FileAction>(FileAction.values);
}

class FileRunLog extends DataClass implements Insertable<FileRunLog> {
  final int id;
  final int runId;
  final int? fileRecordId;
  final FileAction action;
  final String filePath;
  final String? errorMessage;
  final DateTime occurredAt;
  const FileRunLog({
    required this.id,
    required this.runId,
    this.fileRecordId,
    required this.action,
    required this.filePath,
    this.errorMessage,
    required this.occurredAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['run_id'] = Variable<int>(runId);
    if (!nullToAbsent || fileRecordId != null) {
      map['file_record_id'] = Variable<int>(fileRecordId);
    }
    {
      map['action'] = Variable<int>(
        $FileRunLogsTable.$converteraction.toSql(action),
      );
    }
    map['file_path'] = Variable<String>(filePath);
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    return map;
  }

  FileRunLogsCompanion toCompanion(bool nullToAbsent) {
    return FileRunLogsCompanion(
      id: Value(id),
      runId: Value(runId),
      fileRecordId: fileRecordId == null && nullToAbsent
          ? const Value.absent()
          : Value(fileRecordId),
      action: Value(action),
      filePath: Value(filePath),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
      occurredAt: Value(occurredAt),
    );
  }

  factory FileRunLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FileRunLog(
      id: serializer.fromJson<int>(json['id']),
      runId: serializer.fromJson<int>(json['runId']),
      fileRecordId: serializer.fromJson<int?>(json['fileRecordId']),
      action: $FileRunLogsTable.$converteraction.fromJson(
        serializer.fromJson<int>(json['action']),
      ),
      filePath: serializer.fromJson<String>(json['filePath']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'runId': serializer.toJson<int>(runId),
      'fileRecordId': serializer.toJson<int?>(fileRecordId),
      'action': serializer.toJson<int>(
        $FileRunLogsTable.$converteraction.toJson(action),
      ),
      'filePath': serializer.toJson<String>(filePath),
      'errorMessage': serializer.toJson<String?>(errorMessage),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
    };
  }

  FileRunLog copyWith({
    int? id,
    int? runId,
    Value<int?> fileRecordId = const Value.absent(),
    FileAction? action,
    String? filePath,
    Value<String?> errorMessage = const Value.absent(),
    DateTime? occurredAt,
  }) => FileRunLog(
    id: id ?? this.id,
    runId: runId ?? this.runId,
    fileRecordId: fileRecordId.present ? fileRecordId.value : this.fileRecordId,
    action: action ?? this.action,
    filePath: filePath ?? this.filePath,
    errorMessage: errorMessage.present ? errorMessage.value : this.errorMessage,
    occurredAt: occurredAt ?? this.occurredAt,
  );
  FileRunLog copyWithCompanion(FileRunLogsCompanion data) {
    return FileRunLog(
      id: data.id.present ? data.id.value : this.id,
      runId: data.runId.present ? data.runId.value : this.runId,
      fileRecordId: data.fileRecordId.present
          ? data.fileRecordId.value
          : this.fileRecordId,
      action: data.action.present ? data.action.value : this.action,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FileRunLog(')
          ..write('id: $id, ')
          ..write('runId: $runId, ')
          ..write('fileRecordId: $fileRecordId, ')
          ..write('action: $action, ')
          ..write('filePath: $filePath, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('occurredAt: $occurredAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    runId,
    fileRecordId,
    action,
    filePath,
    errorMessage,
    occurredAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FileRunLog &&
          other.id == this.id &&
          other.runId == this.runId &&
          other.fileRecordId == this.fileRecordId &&
          other.action == this.action &&
          other.filePath == this.filePath &&
          other.errorMessage == this.errorMessage &&
          other.occurredAt == this.occurredAt);
}

class FileRunLogsCompanion extends UpdateCompanion<FileRunLog> {
  final Value<int> id;
  final Value<int> runId;
  final Value<int?> fileRecordId;
  final Value<FileAction> action;
  final Value<String> filePath;
  final Value<String?> errorMessage;
  final Value<DateTime> occurredAt;
  const FileRunLogsCompanion({
    this.id = const Value.absent(),
    this.runId = const Value.absent(),
    this.fileRecordId = const Value.absent(),
    this.action = const Value.absent(),
    this.filePath = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.occurredAt = const Value.absent(),
  });
  FileRunLogsCompanion.insert({
    this.id = const Value.absent(),
    required int runId,
    this.fileRecordId = const Value.absent(),
    required FileAction action,
    required String filePath,
    this.errorMessage = const Value.absent(),
    required DateTime occurredAt,
  }) : runId = Value(runId),
       action = Value(action),
       filePath = Value(filePath),
       occurredAt = Value(occurredAt);
  static Insertable<FileRunLog> custom({
    Expression<int>? id,
    Expression<int>? runId,
    Expression<int>? fileRecordId,
    Expression<int>? action,
    Expression<String>? filePath,
    Expression<String>? errorMessage,
    Expression<DateTime>? occurredAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (runId != null) 'run_id': runId,
      if (fileRecordId != null) 'file_record_id': fileRecordId,
      if (action != null) 'action': action,
      if (filePath != null) 'file_path': filePath,
      if (errorMessage != null) 'error_message': errorMessage,
      if (occurredAt != null) 'occurred_at': occurredAt,
    });
  }

  FileRunLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? runId,
    Value<int?>? fileRecordId,
    Value<FileAction>? action,
    Value<String>? filePath,
    Value<String?>? errorMessage,
    Value<DateTime>? occurredAt,
  }) {
    return FileRunLogsCompanion(
      id: id ?? this.id,
      runId: runId ?? this.runId,
      fileRecordId: fileRecordId ?? this.fileRecordId,
      action: action ?? this.action,
      filePath: filePath ?? this.filePath,
      errorMessage: errorMessage ?? this.errorMessage,
      occurredAt: occurredAt ?? this.occurredAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (runId.present) {
      map['run_id'] = Variable<int>(runId.value);
    }
    if (fileRecordId.present) {
      map['file_record_id'] = Variable<int>(fileRecordId.value);
    }
    if (action.present) {
      map['action'] = Variable<int>(
        $FileRunLogsTable.$converteraction.toSql(action.value),
      );
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FileRunLogsCompanion(')
          ..write('id: $id, ')
          ..write('runId: $runId, ')
          ..write('fileRecordId: $fileRecordId, ')
          ..write('action: $action, ')
          ..write('filePath: $filePath, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('occurredAt: $occurredAt')
          ..write(')'))
        .toString();
  }
}

class $InProgressUploadsTable extends InProgressUploads
    with TableInfo<$InProgressUploadsTable, InProgressUpload> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InProgressUploadsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _jobIdMeta = const VerificationMeta('jobId');
  @override
  late final GeneratedColumn<int> jobId = GeneratedColumn<int>(
    'job_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES jobs (id)',
    ),
  );
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nasTempPathMeta = const VerificationMeta(
    'nasTempPath',
  );
  @override
  late final GeneratedColumn<String> nasTempPath = GeneratedColumn<String>(
    'nas_temp_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nasFinalPathMeta = const VerificationMeta(
    'nasFinalPath',
  );
  @override
  late final GeneratedColumn<String> nasFinalPath = GeneratedColumn<String>(
    'nas_final_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bytesUploadedMeta = const VerificationMeta(
    'bytesUploaded',
  );
  @override
  late final GeneratedColumn<int> bytesUploaded = GeneratedColumn<int>(
    'bytes_uploaded',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalBytesMeta = const VerificationMeta(
    'totalBytes',
  );
  @override
  late final GeneratedColumn<int> totalBytes = GeneratedColumn<int>(
    'total_bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    jobId,
    localPath,
    nasTempPath,
    nasFinalPath,
    bytesUploaded,
    totalBytes,
    startedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'in_progress_uploads';
  @override
  VerificationContext validateIntegrity(
    Insertable<InProgressUpload> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('job_id')) {
      context.handle(
        _jobIdMeta,
        jobId.isAcceptableOrUnknown(data['job_id']!, _jobIdMeta),
      );
    } else if (isInserting) {
      context.missing(_jobIdMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
      );
    } else if (isInserting) {
      context.missing(_localPathMeta);
    }
    if (data.containsKey('nas_temp_path')) {
      context.handle(
        _nasTempPathMeta,
        nasTempPath.isAcceptableOrUnknown(
          data['nas_temp_path']!,
          _nasTempPathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nasTempPathMeta);
    }
    if (data.containsKey('nas_final_path')) {
      context.handle(
        _nasFinalPathMeta,
        nasFinalPath.isAcceptableOrUnknown(
          data['nas_final_path']!,
          _nasFinalPathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nasFinalPathMeta);
    }
    if (data.containsKey('bytes_uploaded')) {
      context.handle(
        _bytesUploadedMeta,
        bytesUploaded.isAcceptableOrUnknown(
          data['bytes_uploaded']!,
          _bytesUploadedMeta,
        ),
      );
    }
    if (data.containsKey('total_bytes')) {
      context.handle(
        _totalBytesMeta,
        totalBytes.isAcceptableOrUnknown(data['total_bytes']!, _totalBytesMeta),
      );
    } else if (isInserting) {
      context.missing(_totalBytesMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InProgressUpload map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InProgressUpload(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      jobId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}job_id'],
      )!,
      localPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_path'],
      )!,
      nasTempPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nas_temp_path'],
      )!,
      nasFinalPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nas_final_path'],
      )!,
      bytesUploaded: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bytes_uploaded'],
      )!,
      totalBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_bytes'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
    );
  }

  @override
  $InProgressUploadsTable createAlias(String alias) {
    return $InProgressUploadsTable(attachedDatabase, alias);
  }
}

class InProgressUpload extends DataClass
    implements Insertable<InProgressUpload> {
  final int id;
  final int jobId;
  final String localPath;
  final String nasTempPath;
  final String nasFinalPath;
  final int bytesUploaded;
  final int totalBytes;
  final DateTime startedAt;
  const InProgressUpload({
    required this.id,
    required this.jobId,
    required this.localPath,
    required this.nasTempPath,
    required this.nasFinalPath,
    required this.bytesUploaded,
    required this.totalBytes,
    required this.startedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['job_id'] = Variable<int>(jobId);
    map['local_path'] = Variable<String>(localPath);
    map['nas_temp_path'] = Variable<String>(nasTempPath);
    map['nas_final_path'] = Variable<String>(nasFinalPath);
    map['bytes_uploaded'] = Variable<int>(bytesUploaded);
    map['total_bytes'] = Variable<int>(totalBytes);
    map['started_at'] = Variable<DateTime>(startedAt);
    return map;
  }

  InProgressUploadsCompanion toCompanion(bool nullToAbsent) {
    return InProgressUploadsCompanion(
      id: Value(id),
      jobId: Value(jobId),
      localPath: Value(localPath),
      nasTempPath: Value(nasTempPath),
      nasFinalPath: Value(nasFinalPath),
      bytesUploaded: Value(bytesUploaded),
      totalBytes: Value(totalBytes),
      startedAt: Value(startedAt),
    );
  }

  factory InProgressUpload.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InProgressUpload(
      id: serializer.fromJson<int>(json['id']),
      jobId: serializer.fromJson<int>(json['jobId']),
      localPath: serializer.fromJson<String>(json['localPath']),
      nasTempPath: serializer.fromJson<String>(json['nasTempPath']),
      nasFinalPath: serializer.fromJson<String>(json['nasFinalPath']),
      bytesUploaded: serializer.fromJson<int>(json['bytesUploaded']),
      totalBytes: serializer.fromJson<int>(json['totalBytes']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'jobId': serializer.toJson<int>(jobId),
      'localPath': serializer.toJson<String>(localPath),
      'nasTempPath': serializer.toJson<String>(nasTempPath),
      'nasFinalPath': serializer.toJson<String>(nasFinalPath),
      'bytesUploaded': serializer.toJson<int>(bytesUploaded),
      'totalBytes': serializer.toJson<int>(totalBytes),
      'startedAt': serializer.toJson<DateTime>(startedAt),
    };
  }

  InProgressUpload copyWith({
    int? id,
    int? jobId,
    String? localPath,
    String? nasTempPath,
    String? nasFinalPath,
    int? bytesUploaded,
    int? totalBytes,
    DateTime? startedAt,
  }) => InProgressUpload(
    id: id ?? this.id,
    jobId: jobId ?? this.jobId,
    localPath: localPath ?? this.localPath,
    nasTempPath: nasTempPath ?? this.nasTempPath,
    nasFinalPath: nasFinalPath ?? this.nasFinalPath,
    bytesUploaded: bytesUploaded ?? this.bytesUploaded,
    totalBytes: totalBytes ?? this.totalBytes,
    startedAt: startedAt ?? this.startedAt,
  );
  InProgressUpload copyWithCompanion(InProgressUploadsCompanion data) {
    return InProgressUpload(
      id: data.id.present ? data.id.value : this.id,
      jobId: data.jobId.present ? data.jobId.value : this.jobId,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      nasTempPath: data.nasTempPath.present
          ? data.nasTempPath.value
          : this.nasTempPath,
      nasFinalPath: data.nasFinalPath.present
          ? data.nasFinalPath.value
          : this.nasFinalPath,
      bytesUploaded: data.bytesUploaded.present
          ? data.bytesUploaded.value
          : this.bytesUploaded,
      totalBytes: data.totalBytes.present
          ? data.totalBytes.value
          : this.totalBytes,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InProgressUpload(')
          ..write('id: $id, ')
          ..write('jobId: $jobId, ')
          ..write('localPath: $localPath, ')
          ..write('nasTempPath: $nasTempPath, ')
          ..write('nasFinalPath: $nasFinalPath, ')
          ..write('bytesUploaded: $bytesUploaded, ')
          ..write('totalBytes: $totalBytes, ')
          ..write('startedAt: $startedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    jobId,
    localPath,
    nasTempPath,
    nasFinalPath,
    bytesUploaded,
    totalBytes,
    startedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InProgressUpload &&
          other.id == this.id &&
          other.jobId == this.jobId &&
          other.localPath == this.localPath &&
          other.nasTempPath == this.nasTempPath &&
          other.nasFinalPath == this.nasFinalPath &&
          other.bytesUploaded == this.bytesUploaded &&
          other.totalBytes == this.totalBytes &&
          other.startedAt == this.startedAt);
}

class InProgressUploadsCompanion extends UpdateCompanion<InProgressUpload> {
  final Value<int> id;
  final Value<int> jobId;
  final Value<String> localPath;
  final Value<String> nasTempPath;
  final Value<String> nasFinalPath;
  final Value<int> bytesUploaded;
  final Value<int> totalBytes;
  final Value<DateTime> startedAt;
  const InProgressUploadsCompanion({
    this.id = const Value.absent(),
    this.jobId = const Value.absent(),
    this.localPath = const Value.absent(),
    this.nasTempPath = const Value.absent(),
    this.nasFinalPath = const Value.absent(),
    this.bytesUploaded = const Value.absent(),
    this.totalBytes = const Value.absent(),
    this.startedAt = const Value.absent(),
  });
  InProgressUploadsCompanion.insert({
    this.id = const Value.absent(),
    required int jobId,
    required String localPath,
    required String nasTempPath,
    required String nasFinalPath,
    this.bytesUploaded = const Value.absent(),
    required int totalBytes,
    required DateTime startedAt,
  }) : jobId = Value(jobId),
       localPath = Value(localPath),
       nasTempPath = Value(nasTempPath),
       nasFinalPath = Value(nasFinalPath),
       totalBytes = Value(totalBytes),
       startedAt = Value(startedAt);
  static Insertable<InProgressUpload> custom({
    Expression<int>? id,
    Expression<int>? jobId,
    Expression<String>? localPath,
    Expression<String>? nasTempPath,
    Expression<String>? nasFinalPath,
    Expression<int>? bytesUploaded,
    Expression<int>? totalBytes,
    Expression<DateTime>? startedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (jobId != null) 'job_id': jobId,
      if (localPath != null) 'local_path': localPath,
      if (nasTempPath != null) 'nas_temp_path': nasTempPath,
      if (nasFinalPath != null) 'nas_final_path': nasFinalPath,
      if (bytesUploaded != null) 'bytes_uploaded': bytesUploaded,
      if (totalBytes != null) 'total_bytes': totalBytes,
      if (startedAt != null) 'started_at': startedAt,
    });
  }

  InProgressUploadsCompanion copyWith({
    Value<int>? id,
    Value<int>? jobId,
    Value<String>? localPath,
    Value<String>? nasTempPath,
    Value<String>? nasFinalPath,
    Value<int>? bytesUploaded,
    Value<int>? totalBytes,
    Value<DateTime>? startedAt,
  }) {
    return InProgressUploadsCompanion(
      id: id ?? this.id,
      jobId: jobId ?? this.jobId,
      localPath: localPath ?? this.localPath,
      nasTempPath: nasTempPath ?? this.nasTempPath,
      nasFinalPath: nasFinalPath ?? this.nasFinalPath,
      bytesUploaded: bytesUploaded ?? this.bytesUploaded,
      totalBytes: totalBytes ?? this.totalBytes,
      startedAt: startedAt ?? this.startedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (jobId.present) {
      map['job_id'] = Variable<int>(jobId.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (nasTempPath.present) {
      map['nas_temp_path'] = Variable<String>(nasTempPath.value);
    }
    if (nasFinalPath.present) {
      map['nas_final_path'] = Variable<String>(nasFinalPath.value);
    }
    if (bytesUploaded.present) {
      map['bytes_uploaded'] = Variable<int>(bytesUploaded.value);
    }
    if (totalBytes.present) {
      map['total_bytes'] = Variable<int>(totalBytes.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InProgressUploadsCompanion(')
          ..write('id: $id, ')
          ..write('jobId: $jobId, ')
          ..write('localPath: $localPath, ')
          ..write('nasTempPath: $nasTempPath, ')
          ..write('nasFinalPath: $nasFinalPath, ')
          ..write('bytesUploaded: $bytesUploaded, ')
          ..write('totalBytes: $totalBytes, ')
          ..write('startedAt: $startedAt')
          ..write(')'))
        .toString();
  }
}

class $GlobalSettingsTable extends GlobalSettings
    with TableInfo<$GlobalSettingsTable, GlobalSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GlobalSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nasHostMeta = const VerificationMeta(
    'nasHost',
  );
  @override
  late final GeneratedColumn<String> nasHost = GeneratedColumn<String>(
    'nas_host',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _nasPortMeta = const VerificationMeta(
    'nasPort',
  );
  @override
  late final GeneratedColumn<int> nasPort = GeneratedColumn<int>(
    'nas_port',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(5006),
  );
  static const VerificationMeta _useHttpsMeta = const VerificationMeta(
    'useHttps',
  );
  @override
  late final GeneratedColumn<bool> useHttps = GeneratedColumn<bool>(
    'use_https',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("use_https" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _nasUsernameMeta = const VerificationMeta(
    'nasUsername',
  );
  @override
  late final GeneratedColumn<String> nasUsername = GeneratedColumn<String>(
    'nas_username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  late final GeneratedColumnWithTypeConverter<ComparisonMethod, int>
  defaultComparisonMethod =
      GeneratedColumn<int>(
        'default_comparison_method',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: Constant(ComparisonMethod.metadata.index),
      ).withConverter<ComparisonMethod>(
        $GlobalSettingsTable.$converterdefaultComparisonMethod,
      );
  @override
  late final GeneratedColumnWithTypeConverter<CompressionType, int>
  defaultCompressionType =
      GeneratedColumn<int>(
        'default_compression_type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: Constant(CompressionType.none.index),
      ).withConverter<CompressionType>(
        $GlobalSettingsTable.$converterdefaultCompressionType,
      );
  static const VerificationMeta _spaceWarnThresholdGbMeta =
      const VerificationMeta('spaceWarnThresholdGb');
  @override
  late final GeneratedColumn<int> spaceWarnThresholdGb = GeneratedColumn<int>(
    'space_warn_threshold_gb',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(10),
  );
  static const VerificationMeta _notificationFlagsMeta = const VerificationMeta(
    'notificationFlags',
  );
  @override
  late final GeneratedColumn<int> notificationFlags = GeneratedColumn<int>(
    'notification_flags',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0xFF),
  );
  static const VerificationMeta _backupExportPathMeta = const VerificationMeta(
    'backupExportPath',
  );
  @override
  late final GeneratedColumn<String> backupExportPath = GeneratedColumn<String>(
    'backup_export_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nasHost,
    nasPort,
    useHttps,
    nasUsername,
    defaultComparisonMethod,
    defaultCompressionType,
    spaceWarnThresholdGb,
    notificationFlags,
    backupExportPath,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'global_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<GlobalSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nas_host')) {
      context.handle(
        _nasHostMeta,
        nasHost.isAcceptableOrUnknown(data['nas_host']!, _nasHostMeta),
      );
    }
    if (data.containsKey('nas_port')) {
      context.handle(
        _nasPortMeta,
        nasPort.isAcceptableOrUnknown(data['nas_port']!, _nasPortMeta),
      );
    }
    if (data.containsKey('use_https')) {
      context.handle(
        _useHttpsMeta,
        useHttps.isAcceptableOrUnknown(data['use_https']!, _useHttpsMeta),
      );
    }
    if (data.containsKey('nas_username')) {
      context.handle(
        _nasUsernameMeta,
        nasUsername.isAcceptableOrUnknown(
          data['nas_username']!,
          _nasUsernameMeta,
        ),
      );
    }
    if (data.containsKey('space_warn_threshold_gb')) {
      context.handle(
        _spaceWarnThresholdGbMeta,
        spaceWarnThresholdGb.isAcceptableOrUnknown(
          data['space_warn_threshold_gb']!,
          _spaceWarnThresholdGbMeta,
        ),
      );
    }
    if (data.containsKey('notification_flags')) {
      context.handle(
        _notificationFlagsMeta,
        notificationFlags.isAcceptableOrUnknown(
          data['notification_flags']!,
          _notificationFlagsMeta,
        ),
      );
    }
    if (data.containsKey('backup_export_path')) {
      context.handle(
        _backupExportPathMeta,
        backupExportPath.isAcceptableOrUnknown(
          data['backup_export_path']!,
          _backupExportPathMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GlobalSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GlobalSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nasHost: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nas_host'],
      )!,
      nasPort: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}nas_port'],
      )!,
      useHttps: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}use_https'],
      )!,
      nasUsername: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nas_username'],
      )!,
      defaultComparisonMethod: $GlobalSettingsTable
          .$converterdefaultComparisonMethod
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data['${effectivePrefix}default_comparison_method'],
            )!,
          ),
      defaultCompressionType: $GlobalSettingsTable
          .$converterdefaultCompressionType
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data['${effectivePrefix}default_compression_type'],
            )!,
          ),
      spaceWarnThresholdGb: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}space_warn_threshold_gb'],
      )!,
      notificationFlags: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}notification_flags'],
      )!,
      backupExportPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}backup_export_path'],
      ),
    );
  }

  @override
  $GlobalSettingsTable createAlias(String alias) {
    return $GlobalSettingsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ComparisonMethod, int, int>
  $converterdefaultComparisonMethod =
      const EnumIndexConverter<ComparisonMethod>(ComparisonMethod.values);
  static JsonTypeConverter2<CompressionType, int, int>
  $converterdefaultCompressionType = const EnumIndexConverter<CompressionType>(
    CompressionType.values,
  );
}

class GlobalSetting extends DataClass implements Insertable<GlobalSetting> {
  final int id;
  final String nasHost;
  final int nasPort;
  final bool useHttps;
  final String nasUsername;
  final ComparisonMethod defaultComparisonMethod;
  final CompressionType defaultCompressionType;
  final int spaceWarnThresholdGb;
  final int notificationFlags;
  final String? backupExportPath;
  const GlobalSetting({
    required this.id,
    required this.nasHost,
    required this.nasPort,
    required this.useHttps,
    required this.nasUsername,
    required this.defaultComparisonMethod,
    required this.defaultCompressionType,
    required this.spaceWarnThresholdGb,
    required this.notificationFlags,
    this.backupExportPath,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nas_host'] = Variable<String>(nasHost);
    map['nas_port'] = Variable<int>(nasPort);
    map['use_https'] = Variable<bool>(useHttps);
    map['nas_username'] = Variable<String>(nasUsername);
    {
      map['default_comparison_method'] = Variable<int>(
        $GlobalSettingsTable.$converterdefaultComparisonMethod.toSql(
          defaultComparisonMethod,
        ),
      );
    }
    {
      map['default_compression_type'] = Variable<int>(
        $GlobalSettingsTable.$converterdefaultCompressionType.toSql(
          defaultCompressionType,
        ),
      );
    }
    map['space_warn_threshold_gb'] = Variable<int>(spaceWarnThresholdGb);
    map['notification_flags'] = Variable<int>(notificationFlags);
    if (!nullToAbsent || backupExportPath != null) {
      map['backup_export_path'] = Variable<String>(backupExportPath);
    }
    return map;
  }

  GlobalSettingsCompanion toCompanion(bool nullToAbsent) {
    return GlobalSettingsCompanion(
      id: Value(id),
      nasHost: Value(nasHost),
      nasPort: Value(nasPort),
      useHttps: Value(useHttps),
      nasUsername: Value(nasUsername),
      defaultComparisonMethod: Value(defaultComparisonMethod),
      defaultCompressionType: Value(defaultCompressionType),
      spaceWarnThresholdGb: Value(spaceWarnThresholdGb),
      notificationFlags: Value(notificationFlags),
      backupExportPath: backupExportPath == null && nullToAbsent
          ? const Value.absent()
          : Value(backupExportPath),
    );
  }

  factory GlobalSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GlobalSetting(
      id: serializer.fromJson<int>(json['id']),
      nasHost: serializer.fromJson<String>(json['nasHost']),
      nasPort: serializer.fromJson<int>(json['nasPort']),
      useHttps: serializer.fromJson<bool>(json['useHttps']),
      nasUsername: serializer.fromJson<String>(json['nasUsername']),
      defaultComparisonMethod: $GlobalSettingsTable
          .$converterdefaultComparisonMethod
          .fromJson(serializer.fromJson<int>(json['defaultComparisonMethod'])),
      defaultCompressionType: $GlobalSettingsTable
          .$converterdefaultCompressionType
          .fromJson(serializer.fromJson<int>(json['defaultCompressionType'])),
      spaceWarnThresholdGb: serializer.fromJson<int>(
        json['spaceWarnThresholdGb'],
      ),
      notificationFlags: serializer.fromJson<int>(json['notificationFlags']),
      backupExportPath: serializer.fromJson<String?>(json['backupExportPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nasHost': serializer.toJson<String>(nasHost),
      'nasPort': serializer.toJson<int>(nasPort),
      'useHttps': serializer.toJson<bool>(useHttps),
      'nasUsername': serializer.toJson<String>(nasUsername),
      'defaultComparisonMethod': serializer.toJson<int>(
        $GlobalSettingsTable.$converterdefaultComparisonMethod.toJson(
          defaultComparisonMethod,
        ),
      ),
      'defaultCompressionType': serializer.toJson<int>(
        $GlobalSettingsTable.$converterdefaultCompressionType.toJson(
          defaultCompressionType,
        ),
      ),
      'spaceWarnThresholdGb': serializer.toJson<int>(spaceWarnThresholdGb),
      'notificationFlags': serializer.toJson<int>(notificationFlags),
      'backupExportPath': serializer.toJson<String?>(backupExportPath),
    };
  }

  GlobalSetting copyWith({
    int? id,
    String? nasHost,
    int? nasPort,
    bool? useHttps,
    String? nasUsername,
    ComparisonMethod? defaultComparisonMethod,
    CompressionType? defaultCompressionType,
    int? spaceWarnThresholdGb,
    int? notificationFlags,
    Value<String?> backupExportPath = const Value.absent(),
  }) => GlobalSetting(
    id: id ?? this.id,
    nasHost: nasHost ?? this.nasHost,
    nasPort: nasPort ?? this.nasPort,
    useHttps: useHttps ?? this.useHttps,
    nasUsername: nasUsername ?? this.nasUsername,
    defaultComparisonMethod:
        defaultComparisonMethod ?? this.defaultComparisonMethod,
    defaultCompressionType:
        defaultCompressionType ?? this.defaultCompressionType,
    spaceWarnThresholdGb: spaceWarnThresholdGb ?? this.spaceWarnThresholdGb,
    notificationFlags: notificationFlags ?? this.notificationFlags,
    backupExportPath: backupExportPath.present
        ? backupExportPath.value
        : this.backupExportPath,
  );
  GlobalSetting copyWithCompanion(GlobalSettingsCompanion data) {
    return GlobalSetting(
      id: data.id.present ? data.id.value : this.id,
      nasHost: data.nasHost.present ? data.nasHost.value : this.nasHost,
      nasPort: data.nasPort.present ? data.nasPort.value : this.nasPort,
      useHttps: data.useHttps.present ? data.useHttps.value : this.useHttps,
      nasUsername: data.nasUsername.present
          ? data.nasUsername.value
          : this.nasUsername,
      defaultComparisonMethod: data.defaultComparisonMethod.present
          ? data.defaultComparisonMethod.value
          : this.defaultComparisonMethod,
      defaultCompressionType: data.defaultCompressionType.present
          ? data.defaultCompressionType.value
          : this.defaultCompressionType,
      spaceWarnThresholdGb: data.spaceWarnThresholdGb.present
          ? data.spaceWarnThresholdGb.value
          : this.spaceWarnThresholdGb,
      notificationFlags: data.notificationFlags.present
          ? data.notificationFlags.value
          : this.notificationFlags,
      backupExportPath: data.backupExportPath.present
          ? data.backupExportPath.value
          : this.backupExportPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GlobalSetting(')
          ..write('id: $id, ')
          ..write('nasHost: $nasHost, ')
          ..write('nasPort: $nasPort, ')
          ..write('useHttps: $useHttps, ')
          ..write('nasUsername: $nasUsername, ')
          ..write('defaultComparisonMethod: $defaultComparisonMethod, ')
          ..write('defaultCompressionType: $defaultCompressionType, ')
          ..write('spaceWarnThresholdGb: $spaceWarnThresholdGb, ')
          ..write('notificationFlags: $notificationFlags, ')
          ..write('backupExportPath: $backupExportPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nasHost,
    nasPort,
    useHttps,
    nasUsername,
    defaultComparisonMethod,
    defaultCompressionType,
    spaceWarnThresholdGb,
    notificationFlags,
    backupExportPath,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GlobalSetting &&
          other.id == this.id &&
          other.nasHost == this.nasHost &&
          other.nasPort == this.nasPort &&
          other.useHttps == this.useHttps &&
          other.nasUsername == this.nasUsername &&
          other.defaultComparisonMethod == this.defaultComparisonMethod &&
          other.defaultCompressionType == this.defaultCompressionType &&
          other.spaceWarnThresholdGb == this.spaceWarnThresholdGb &&
          other.notificationFlags == this.notificationFlags &&
          other.backupExportPath == this.backupExportPath);
}

class GlobalSettingsCompanion extends UpdateCompanion<GlobalSetting> {
  final Value<int> id;
  final Value<String> nasHost;
  final Value<int> nasPort;
  final Value<bool> useHttps;
  final Value<String> nasUsername;
  final Value<ComparisonMethod> defaultComparisonMethod;
  final Value<CompressionType> defaultCompressionType;
  final Value<int> spaceWarnThresholdGb;
  final Value<int> notificationFlags;
  final Value<String?> backupExportPath;
  const GlobalSettingsCompanion({
    this.id = const Value.absent(),
    this.nasHost = const Value.absent(),
    this.nasPort = const Value.absent(),
    this.useHttps = const Value.absent(),
    this.nasUsername = const Value.absent(),
    this.defaultComparisonMethod = const Value.absent(),
    this.defaultCompressionType = const Value.absent(),
    this.spaceWarnThresholdGb = const Value.absent(),
    this.notificationFlags = const Value.absent(),
    this.backupExportPath = const Value.absent(),
  });
  GlobalSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.nasHost = const Value.absent(),
    this.nasPort = const Value.absent(),
    this.useHttps = const Value.absent(),
    this.nasUsername = const Value.absent(),
    this.defaultComparisonMethod = const Value.absent(),
    this.defaultCompressionType = const Value.absent(),
    this.spaceWarnThresholdGb = const Value.absent(),
    this.notificationFlags = const Value.absent(),
    this.backupExportPath = const Value.absent(),
  });
  static Insertable<GlobalSetting> custom({
    Expression<int>? id,
    Expression<String>? nasHost,
    Expression<int>? nasPort,
    Expression<bool>? useHttps,
    Expression<String>? nasUsername,
    Expression<int>? defaultComparisonMethod,
    Expression<int>? defaultCompressionType,
    Expression<int>? spaceWarnThresholdGb,
    Expression<int>? notificationFlags,
    Expression<String>? backupExportPath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nasHost != null) 'nas_host': nasHost,
      if (nasPort != null) 'nas_port': nasPort,
      if (useHttps != null) 'use_https': useHttps,
      if (nasUsername != null) 'nas_username': nasUsername,
      if (defaultComparisonMethod != null)
        'default_comparison_method': defaultComparisonMethod,
      if (defaultCompressionType != null)
        'default_compression_type': defaultCompressionType,
      if (spaceWarnThresholdGb != null)
        'space_warn_threshold_gb': spaceWarnThresholdGb,
      if (notificationFlags != null) 'notification_flags': notificationFlags,
      if (backupExportPath != null) 'backup_export_path': backupExportPath,
    });
  }

  GlobalSettingsCompanion copyWith({
    Value<int>? id,
    Value<String>? nasHost,
    Value<int>? nasPort,
    Value<bool>? useHttps,
    Value<String>? nasUsername,
    Value<ComparisonMethod>? defaultComparisonMethod,
    Value<CompressionType>? defaultCompressionType,
    Value<int>? spaceWarnThresholdGb,
    Value<int>? notificationFlags,
    Value<String?>? backupExportPath,
  }) {
    return GlobalSettingsCompanion(
      id: id ?? this.id,
      nasHost: nasHost ?? this.nasHost,
      nasPort: nasPort ?? this.nasPort,
      useHttps: useHttps ?? this.useHttps,
      nasUsername: nasUsername ?? this.nasUsername,
      defaultComparisonMethod:
          defaultComparisonMethod ?? this.defaultComparisonMethod,
      defaultCompressionType:
          defaultCompressionType ?? this.defaultCompressionType,
      spaceWarnThresholdGb: spaceWarnThresholdGb ?? this.spaceWarnThresholdGb,
      notificationFlags: notificationFlags ?? this.notificationFlags,
      backupExportPath: backupExportPath ?? this.backupExportPath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nasHost.present) {
      map['nas_host'] = Variable<String>(nasHost.value);
    }
    if (nasPort.present) {
      map['nas_port'] = Variable<int>(nasPort.value);
    }
    if (useHttps.present) {
      map['use_https'] = Variable<bool>(useHttps.value);
    }
    if (nasUsername.present) {
      map['nas_username'] = Variable<String>(nasUsername.value);
    }
    if (defaultComparisonMethod.present) {
      map['default_comparison_method'] = Variable<int>(
        $GlobalSettingsTable.$converterdefaultComparisonMethod.toSql(
          defaultComparisonMethod.value,
        ),
      );
    }
    if (defaultCompressionType.present) {
      map['default_compression_type'] = Variable<int>(
        $GlobalSettingsTable.$converterdefaultCompressionType.toSql(
          defaultCompressionType.value,
        ),
      );
    }
    if (spaceWarnThresholdGb.present) {
      map['space_warn_threshold_gb'] = Variable<int>(
        spaceWarnThresholdGb.value,
      );
    }
    if (notificationFlags.present) {
      map['notification_flags'] = Variable<int>(notificationFlags.value);
    }
    if (backupExportPath.present) {
      map['backup_export_path'] = Variable<String>(backupExportPath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GlobalSettingsCompanion(')
          ..write('id: $id, ')
          ..write('nasHost: $nasHost, ')
          ..write('nasPort: $nasPort, ')
          ..write('useHttps: $useHttps, ')
          ..write('nasUsername: $nasUsername, ')
          ..write('defaultComparisonMethod: $defaultComparisonMethod, ')
          ..write('defaultCompressionType: $defaultCompressionType, ')
          ..write('spaceWarnThresholdGb: $spaceWarnThresholdGb, ')
          ..write('notificationFlags: $notificationFlags, ')
          ..write('backupExportPath: $backupExportPath')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $JobsTable jobs = $JobsTable(this);
  late final $JobRunsTable jobRuns = $JobRunsTable(this);
  late final $FileRecordsTable fileRecords = $FileRecordsTable(this);
  late final $FileRunLogsTable fileRunLogs = $FileRunLogsTable(this);
  late final $InProgressUploadsTable inProgressUploads =
      $InProgressUploadsTable(this);
  late final $GlobalSettingsTable globalSettings = $GlobalSettingsTable(this);
  late final JobsDao jobsDao = JobsDao(this as AppDatabase);
  late final RunsDao runsDao = RunsDao(this as AppDatabase);
  late final FilesDao filesDao = FilesDao(this as AppDatabase);
  late final SettingsDao settingsDao = SettingsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    jobs,
    jobRuns,
    fileRecords,
    fileRunLogs,
    inProgressUploads,
    globalSettings,
  ];
}

typedef $$JobsTableCreateCompanionBuilder =
    JobsCompanion Function({
      Value<int> id,
      required String name,
      required JobType jobType,
      required String sourcePath,
      required String destinationNasPath,
      required ScheduleType scheduleType,
      Value<String?> scheduleConfig,
      required BackupStrategy backupStrategy,
      Value<DateTime?> fromDate,
      required ComparisonMethod comparisonMethod,
      Value<ChangePolicy?> changePolicy,
      required CompressionType compressionType,
      Value<int?> retentionCount,
      Value<int?> retentionDays,
      Value<bool> isEnabled,
      required DateTime createdAt,
      Value<DateTime?> lastRunAt,
      Value<String?> lastRunStatus,
    });
typedef $$JobsTableUpdateCompanionBuilder =
    JobsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<JobType> jobType,
      Value<String> sourcePath,
      Value<String> destinationNasPath,
      Value<ScheduleType> scheduleType,
      Value<String?> scheduleConfig,
      Value<BackupStrategy> backupStrategy,
      Value<DateTime?> fromDate,
      Value<ComparisonMethod> comparisonMethod,
      Value<ChangePolicy?> changePolicy,
      Value<CompressionType> compressionType,
      Value<int?> retentionCount,
      Value<int?> retentionDays,
      Value<bool> isEnabled,
      Value<DateTime> createdAt,
      Value<DateTime?> lastRunAt,
      Value<String?> lastRunStatus,
    });

final class $$JobsTableReferences
    extends BaseReferences<_$AppDatabase, $JobsTable, Job> {
  $$JobsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$JobRunsTable, List<JobRun>> _jobRunsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.jobRuns,
    aliasName: $_aliasNameGenerator(db.jobs.id, db.jobRuns.jobId),
  );

  $$JobRunsTableProcessedTableManager get jobRunsRefs {
    final manager = $$JobRunsTableTableManager(
      $_db,
      $_db.jobRuns,
    ).filter((f) => f.jobId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_jobRunsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FileRecordsTable, List<FileRecord>>
  _fileRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.fileRecords,
    aliasName: $_aliasNameGenerator(db.jobs.id, db.fileRecords.jobId),
  );

  $$FileRecordsTableProcessedTableManager get fileRecordsRefs {
    final manager = $$FileRecordsTableTableManager(
      $_db,
      $_db.fileRecords,
    ).filter((f) => f.jobId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_fileRecordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InProgressUploadsTable, List<InProgressUpload>>
  _inProgressUploadsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.inProgressUploads,
        aliasName: $_aliasNameGenerator(db.jobs.id, db.inProgressUploads.jobId),
      );

  $$InProgressUploadsTableProcessedTableManager get inProgressUploadsRefs {
    final manager = $$InProgressUploadsTableTableManager(
      $_db,
      $_db.inProgressUploads,
    ).filter((f) => f.jobId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _inProgressUploadsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$JobsTableFilterComposer extends Composer<_$AppDatabase, $JobsTable> {
  $$JobsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<JobType, JobType, int> get jobType =>
      $composableBuilder(
        column: $table.jobType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get sourcePath => $composableBuilder(
    column: $table.sourcePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get destinationNasPath => $composableBuilder(
    column: $table.destinationNasPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ScheduleType, ScheduleType, int>
  get scheduleType => $composableBuilder(
    column: $table.scheduleType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get scheduleConfig => $composableBuilder(
    column: $table.scheduleConfig,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<BackupStrategy, BackupStrategy, int>
  get backupStrategy => $composableBuilder(
    column: $table.backupStrategy,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get fromDate => $composableBuilder(
    column: $table.fromDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ComparisonMethod, ComparisonMethod, int>
  get comparisonMethod => $composableBuilder(
    column: $table.comparisonMethod,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<ChangePolicy?, ChangePolicy, int>
  get changePolicy => $composableBuilder(
    column: $table.changePolicy,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<CompressionType, CompressionType, int>
  get compressionType => $composableBuilder(
    column: $table.compressionType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get retentionCount => $composableBuilder(
    column: $table.retentionCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retentionDays => $composableBuilder(
    column: $table.retentionDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastRunAt => $composableBuilder(
    column: $table.lastRunAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastRunStatus => $composableBuilder(
    column: $table.lastRunStatus,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> jobRunsRefs(
    Expression<bool> Function($$JobRunsTableFilterComposer f) f,
  ) {
    final $$JobRunsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.jobRuns,
      getReferencedColumn: (t) => t.jobId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobRunsTableFilterComposer(
            $db: $db,
            $table: $db.jobRuns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> fileRecordsRefs(
    Expression<bool> Function($$FileRecordsTableFilterComposer f) f,
  ) {
    final $$FileRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fileRecords,
      getReferencedColumn: (t) => t.jobId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FileRecordsTableFilterComposer(
            $db: $db,
            $table: $db.fileRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> inProgressUploadsRefs(
    Expression<bool> Function($$InProgressUploadsTableFilterComposer f) f,
  ) {
    final $$InProgressUploadsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.inProgressUploads,
      getReferencedColumn: (t) => t.jobId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InProgressUploadsTableFilterComposer(
            $db: $db,
            $table: $db.inProgressUploads,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$JobsTableOrderingComposer extends Composer<_$AppDatabase, $JobsTable> {
  $$JobsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get jobType => $composableBuilder(
    column: $table.jobType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourcePath => $composableBuilder(
    column: $table.sourcePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get destinationNasPath => $composableBuilder(
    column: $table.destinationNasPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scheduleType => $composableBuilder(
    column: $table.scheduleType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scheduleConfig => $composableBuilder(
    column: $table.scheduleConfig,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get backupStrategy => $composableBuilder(
    column: $table.backupStrategy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fromDate => $composableBuilder(
    column: $table.fromDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get comparisonMethod => $composableBuilder(
    column: $table.comparisonMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get changePolicy => $composableBuilder(
    column: $table.changePolicy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get compressionType => $composableBuilder(
    column: $table.compressionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retentionCount => $composableBuilder(
    column: $table.retentionCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retentionDays => $composableBuilder(
    column: $table.retentionDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastRunAt => $composableBuilder(
    column: $table.lastRunAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastRunStatus => $composableBuilder(
    column: $table.lastRunStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$JobsTableAnnotationComposer
    extends Composer<_$AppDatabase, $JobsTable> {
  $$JobsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<JobType, int> get jobType =>
      $composableBuilder(column: $table.jobType, builder: (column) => column);

  GeneratedColumn<String> get sourcePath => $composableBuilder(
    column: $table.sourcePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get destinationNasPath => $composableBuilder(
    column: $table.destinationNasPath,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<ScheduleType, int> get scheduleType =>
      $composableBuilder(
        column: $table.scheduleType,
        builder: (column) => column,
      );

  GeneratedColumn<String> get scheduleConfig => $composableBuilder(
    column: $table.scheduleConfig,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<BackupStrategy, int> get backupStrategy =>
      $composableBuilder(
        column: $table.backupStrategy,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get fromDate =>
      $composableBuilder(column: $table.fromDate, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ComparisonMethod, int>
  get comparisonMethod => $composableBuilder(
    column: $table.comparisonMethod,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<ChangePolicy?, int> get changePolicy =>
      $composableBuilder(
        column: $table.changePolicy,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<CompressionType, int> get compressionType =>
      $composableBuilder(
        column: $table.compressionType,
        builder: (column) => column,
      );

  GeneratedColumn<int> get retentionCount => $composableBuilder(
    column: $table.retentionCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get retentionDays => $composableBuilder(
    column: $table.retentionDays,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastRunAt =>
      $composableBuilder(column: $table.lastRunAt, builder: (column) => column);

  GeneratedColumn<String> get lastRunStatus => $composableBuilder(
    column: $table.lastRunStatus,
    builder: (column) => column,
  );

  Expression<T> jobRunsRefs<T extends Object>(
    Expression<T> Function($$JobRunsTableAnnotationComposer a) f,
  ) {
    final $$JobRunsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.jobRuns,
      getReferencedColumn: (t) => t.jobId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobRunsTableAnnotationComposer(
            $db: $db,
            $table: $db.jobRuns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> fileRecordsRefs<T extends Object>(
    Expression<T> Function($$FileRecordsTableAnnotationComposer a) f,
  ) {
    final $$FileRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fileRecords,
      getReferencedColumn: (t) => t.jobId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FileRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.fileRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> inProgressUploadsRefs<T extends Object>(
    Expression<T> Function($$InProgressUploadsTableAnnotationComposer a) f,
  ) {
    final $$InProgressUploadsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.inProgressUploads,
          getReferencedColumn: (t) => t.jobId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InProgressUploadsTableAnnotationComposer(
                $db: $db,
                $table: $db.inProgressUploads,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$JobsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JobsTable,
          Job,
          $$JobsTableFilterComposer,
          $$JobsTableOrderingComposer,
          $$JobsTableAnnotationComposer,
          $$JobsTableCreateCompanionBuilder,
          $$JobsTableUpdateCompanionBuilder,
          (Job, $$JobsTableReferences),
          Job,
          PrefetchHooks Function({
            bool jobRunsRefs,
            bool fileRecordsRefs,
            bool inProgressUploadsRefs,
          })
        > {
  $$JobsTableTableManager(_$AppDatabase db, $JobsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JobsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JobsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JobsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<JobType> jobType = const Value.absent(),
                Value<String> sourcePath = const Value.absent(),
                Value<String> destinationNasPath = const Value.absent(),
                Value<ScheduleType> scheduleType = const Value.absent(),
                Value<String?> scheduleConfig = const Value.absent(),
                Value<BackupStrategy> backupStrategy = const Value.absent(),
                Value<DateTime?> fromDate = const Value.absent(),
                Value<ComparisonMethod> comparisonMethod = const Value.absent(),
                Value<ChangePolicy?> changePolicy = const Value.absent(),
                Value<CompressionType> compressionType = const Value.absent(),
                Value<int?> retentionCount = const Value.absent(),
                Value<int?> retentionDays = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> lastRunAt = const Value.absent(),
                Value<String?> lastRunStatus = const Value.absent(),
              }) => JobsCompanion(
                id: id,
                name: name,
                jobType: jobType,
                sourcePath: sourcePath,
                destinationNasPath: destinationNasPath,
                scheduleType: scheduleType,
                scheduleConfig: scheduleConfig,
                backupStrategy: backupStrategy,
                fromDate: fromDate,
                comparisonMethod: comparisonMethod,
                changePolicy: changePolicy,
                compressionType: compressionType,
                retentionCount: retentionCount,
                retentionDays: retentionDays,
                isEnabled: isEnabled,
                createdAt: createdAt,
                lastRunAt: lastRunAt,
                lastRunStatus: lastRunStatus,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required JobType jobType,
                required String sourcePath,
                required String destinationNasPath,
                required ScheduleType scheduleType,
                Value<String?> scheduleConfig = const Value.absent(),
                required BackupStrategy backupStrategy,
                Value<DateTime?> fromDate = const Value.absent(),
                required ComparisonMethod comparisonMethod,
                Value<ChangePolicy?> changePolicy = const Value.absent(),
                required CompressionType compressionType,
                Value<int?> retentionCount = const Value.absent(),
                Value<int?> retentionDays = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> lastRunAt = const Value.absent(),
                Value<String?> lastRunStatus = const Value.absent(),
              }) => JobsCompanion.insert(
                id: id,
                name: name,
                jobType: jobType,
                sourcePath: sourcePath,
                destinationNasPath: destinationNasPath,
                scheduleType: scheduleType,
                scheduleConfig: scheduleConfig,
                backupStrategy: backupStrategy,
                fromDate: fromDate,
                comparisonMethod: comparisonMethod,
                changePolicy: changePolicy,
                compressionType: compressionType,
                retentionCount: retentionCount,
                retentionDays: retentionDays,
                isEnabled: isEnabled,
                createdAt: createdAt,
                lastRunAt: lastRunAt,
                lastRunStatus: lastRunStatus,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$JobsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                jobRunsRefs = false,
                fileRecordsRefs = false,
                inProgressUploadsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (jobRunsRefs) db.jobRuns,
                    if (fileRecordsRefs) db.fileRecords,
                    if (inProgressUploadsRefs) db.inProgressUploads,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (jobRunsRefs)
                        await $_getPrefetchedData<Job, $JobsTable, JobRun>(
                          currentTable: table,
                          referencedTable: $$JobsTableReferences
                              ._jobRunsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$JobsTableReferences(db, table, p0).jobRunsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.jobId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (fileRecordsRefs)
                        await $_getPrefetchedData<Job, $JobsTable, FileRecord>(
                          currentTable: table,
                          referencedTable: $$JobsTableReferences
                              ._fileRecordsRefsTable(db),
                          managerFromTypedResult: (p0) => $$JobsTableReferences(
                            db,
                            table,
                            p0,
                          ).fileRecordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.jobId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (inProgressUploadsRefs)
                        await $_getPrefetchedData<
                          Job,
                          $JobsTable,
                          InProgressUpload
                        >(
                          currentTable: table,
                          referencedTable: $$JobsTableReferences
                              ._inProgressUploadsRefsTable(db),
                          managerFromTypedResult: (p0) => $$JobsTableReferences(
                            db,
                            table,
                            p0,
                          ).inProgressUploadsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.jobId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$JobsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JobsTable,
      Job,
      $$JobsTableFilterComposer,
      $$JobsTableOrderingComposer,
      $$JobsTableAnnotationComposer,
      $$JobsTableCreateCompanionBuilder,
      $$JobsTableUpdateCompanionBuilder,
      (Job, $$JobsTableReferences),
      Job,
      PrefetchHooks Function({
        bool jobRunsRefs,
        bool fileRecordsRefs,
        bool inProgressUploadsRefs,
      })
    >;
typedef $$JobRunsTableCreateCompanionBuilder =
    JobRunsCompanion Function({
      Value<int> id,
      required int jobId,
      required DateTime startedAt,
      Value<DateTime?> completedAt,
      required RunStatus status,
      Value<int> filesScanned,
      Value<int> filesUploaded,
      Value<int> filesSkipped,
      Value<int> filesFailed,
      Value<int> bytesTransferred,
      Value<String?> errorSummary,
    });
typedef $$JobRunsTableUpdateCompanionBuilder =
    JobRunsCompanion Function({
      Value<int> id,
      Value<int> jobId,
      Value<DateTime> startedAt,
      Value<DateTime?> completedAt,
      Value<RunStatus> status,
      Value<int> filesScanned,
      Value<int> filesUploaded,
      Value<int> filesSkipped,
      Value<int> filesFailed,
      Value<int> bytesTransferred,
      Value<String?> errorSummary,
    });

final class $$JobRunsTableReferences
    extends BaseReferences<_$AppDatabase, $JobRunsTable, JobRun> {
  $$JobRunsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $JobsTable _jobIdTable(_$AppDatabase db) =>
      db.jobs.createAlias($_aliasNameGenerator(db.jobRuns.jobId, db.jobs.id));

  $$JobsTableProcessedTableManager get jobId {
    final $_column = $_itemColumn<int>('job_id')!;

    final manager = $$JobsTableTableManager(
      $_db,
      $_db.jobs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_jobIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$FileRunLogsTable, List<FileRunLog>>
  _fileRunLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.fileRunLogs,
    aliasName: $_aliasNameGenerator(db.jobRuns.id, db.fileRunLogs.runId),
  );

  $$FileRunLogsTableProcessedTableManager get fileRunLogsRefs {
    final manager = $$FileRunLogsTableTableManager(
      $_db,
      $_db.fileRunLogs,
    ).filter((f) => f.runId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_fileRunLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$JobRunsTableFilterComposer
    extends Composer<_$AppDatabase, $JobRunsTable> {
  $$JobRunsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<RunStatus, RunStatus, int> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get filesScanned => $composableBuilder(
    column: $table.filesScanned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get filesUploaded => $composableBuilder(
    column: $table.filesUploaded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get filesSkipped => $composableBuilder(
    column: $table.filesSkipped,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get filesFailed => $composableBuilder(
    column: $table.filesFailed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bytesTransferred => $composableBuilder(
    column: $table.bytesTransferred,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorSummary => $composableBuilder(
    column: $table.errorSummary,
    builder: (column) => ColumnFilters(column),
  );

  $$JobsTableFilterComposer get jobId {
    final $$JobsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jobId,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableFilterComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> fileRunLogsRefs(
    Expression<bool> Function($$FileRunLogsTableFilterComposer f) f,
  ) {
    final $$FileRunLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fileRunLogs,
      getReferencedColumn: (t) => t.runId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FileRunLogsTableFilterComposer(
            $db: $db,
            $table: $db.fileRunLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$JobRunsTableOrderingComposer
    extends Composer<_$AppDatabase, $JobRunsTable> {
  $$JobRunsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get filesScanned => $composableBuilder(
    column: $table.filesScanned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get filesUploaded => $composableBuilder(
    column: $table.filesUploaded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get filesSkipped => $composableBuilder(
    column: $table.filesSkipped,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get filesFailed => $composableBuilder(
    column: $table.filesFailed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bytesTransferred => $composableBuilder(
    column: $table.bytesTransferred,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorSummary => $composableBuilder(
    column: $table.errorSummary,
    builder: (column) => ColumnOrderings(column),
  );

  $$JobsTableOrderingComposer get jobId {
    final $$JobsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jobId,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableOrderingComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JobRunsTableAnnotationComposer
    extends Composer<_$AppDatabase, $JobRunsTable> {
  $$JobRunsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<RunStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get filesScanned => $composableBuilder(
    column: $table.filesScanned,
    builder: (column) => column,
  );

  GeneratedColumn<int> get filesUploaded => $composableBuilder(
    column: $table.filesUploaded,
    builder: (column) => column,
  );

  GeneratedColumn<int> get filesSkipped => $composableBuilder(
    column: $table.filesSkipped,
    builder: (column) => column,
  );

  GeneratedColumn<int> get filesFailed => $composableBuilder(
    column: $table.filesFailed,
    builder: (column) => column,
  );

  GeneratedColumn<int> get bytesTransferred => $composableBuilder(
    column: $table.bytesTransferred,
    builder: (column) => column,
  );

  GeneratedColumn<String> get errorSummary => $composableBuilder(
    column: $table.errorSummary,
    builder: (column) => column,
  );

  $$JobsTableAnnotationComposer get jobId {
    final $$JobsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jobId,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableAnnotationComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> fileRunLogsRefs<T extends Object>(
    Expression<T> Function($$FileRunLogsTableAnnotationComposer a) f,
  ) {
    final $$FileRunLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fileRunLogs,
      getReferencedColumn: (t) => t.runId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FileRunLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.fileRunLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$JobRunsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JobRunsTable,
          JobRun,
          $$JobRunsTableFilterComposer,
          $$JobRunsTableOrderingComposer,
          $$JobRunsTableAnnotationComposer,
          $$JobRunsTableCreateCompanionBuilder,
          $$JobRunsTableUpdateCompanionBuilder,
          (JobRun, $$JobRunsTableReferences),
          JobRun,
          PrefetchHooks Function({bool jobId, bool fileRunLogsRefs})
        > {
  $$JobRunsTableTableManager(_$AppDatabase db, $JobRunsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JobRunsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JobRunsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JobRunsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> jobId = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<RunStatus> status = const Value.absent(),
                Value<int> filesScanned = const Value.absent(),
                Value<int> filesUploaded = const Value.absent(),
                Value<int> filesSkipped = const Value.absent(),
                Value<int> filesFailed = const Value.absent(),
                Value<int> bytesTransferred = const Value.absent(),
                Value<String?> errorSummary = const Value.absent(),
              }) => JobRunsCompanion(
                id: id,
                jobId: jobId,
                startedAt: startedAt,
                completedAt: completedAt,
                status: status,
                filesScanned: filesScanned,
                filesUploaded: filesUploaded,
                filesSkipped: filesSkipped,
                filesFailed: filesFailed,
                bytesTransferred: bytesTransferred,
                errorSummary: errorSummary,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int jobId,
                required DateTime startedAt,
                Value<DateTime?> completedAt = const Value.absent(),
                required RunStatus status,
                Value<int> filesScanned = const Value.absent(),
                Value<int> filesUploaded = const Value.absent(),
                Value<int> filesSkipped = const Value.absent(),
                Value<int> filesFailed = const Value.absent(),
                Value<int> bytesTransferred = const Value.absent(),
                Value<String?> errorSummary = const Value.absent(),
              }) => JobRunsCompanion.insert(
                id: id,
                jobId: jobId,
                startedAt: startedAt,
                completedAt: completedAt,
                status: status,
                filesScanned: filesScanned,
                filesUploaded: filesUploaded,
                filesSkipped: filesSkipped,
                filesFailed: filesFailed,
                bytesTransferred: bytesTransferred,
                errorSummary: errorSummary,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$JobRunsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({jobId = false, fileRunLogsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (fileRunLogsRefs) db.fileRunLogs],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (jobId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.jobId,
                                referencedTable: $$JobRunsTableReferences
                                    ._jobIdTable(db),
                                referencedColumn: $$JobRunsTableReferences
                                    ._jobIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (fileRunLogsRefs)
                    await $_getPrefetchedData<
                      JobRun,
                      $JobRunsTable,
                      FileRunLog
                    >(
                      currentTable: table,
                      referencedTable: $$JobRunsTableReferences
                          ._fileRunLogsRefsTable(db),
                      managerFromTypedResult: (p0) => $$JobRunsTableReferences(
                        db,
                        table,
                        p0,
                      ).fileRunLogsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.runId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$JobRunsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JobRunsTable,
      JobRun,
      $$JobRunsTableFilterComposer,
      $$JobRunsTableOrderingComposer,
      $$JobRunsTableAnnotationComposer,
      $$JobRunsTableCreateCompanionBuilder,
      $$JobRunsTableUpdateCompanionBuilder,
      (JobRun, $$JobRunsTableReferences),
      JobRun,
      PrefetchHooks Function({bool jobId, bool fileRunLogsRefs})
    >;
typedef $$FileRecordsTableCreateCompanionBuilder =
    FileRecordsCompanion Function({
      Value<int> id,
      required int jobId,
      required String relativePath,
      required String nasPath,
      required int sizeBytes,
      required DateTime lastModified,
      Value<String?> hash,
      Value<DateTime?> lastBackedUpAt,
      required FileStatus lastStatus,
    });
typedef $$FileRecordsTableUpdateCompanionBuilder =
    FileRecordsCompanion Function({
      Value<int> id,
      Value<int> jobId,
      Value<String> relativePath,
      Value<String> nasPath,
      Value<int> sizeBytes,
      Value<DateTime> lastModified,
      Value<String?> hash,
      Value<DateTime?> lastBackedUpAt,
      Value<FileStatus> lastStatus,
    });

final class $$FileRecordsTableReferences
    extends BaseReferences<_$AppDatabase, $FileRecordsTable, FileRecord> {
  $$FileRecordsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $JobsTable _jobIdTable(_$AppDatabase db) => db.jobs.createAlias(
    $_aliasNameGenerator(db.fileRecords.jobId, db.jobs.id),
  );

  $$JobsTableProcessedTableManager get jobId {
    final $_column = $_itemColumn<int>('job_id')!;

    final manager = $$JobsTableTableManager(
      $_db,
      $_db.jobs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_jobIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$FileRunLogsTable, List<FileRunLog>>
  _fileRunLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.fileRunLogs,
    aliasName: $_aliasNameGenerator(
      db.fileRecords.id,
      db.fileRunLogs.fileRecordId,
    ),
  );

  $$FileRunLogsTableProcessedTableManager get fileRunLogsRefs {
    final manager = $$FileRunLogsTableTableManager(
      $_db,
      $_db.fileRunLogs,
    ).filter((f) => f.fileRecordId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_fileRunLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FileRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $FileRecordsTable> {
  $$FileRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nasPath => $composableBuilder(
    column: $table.nasPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hash => $composableBuilder(
    column: $table.hash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastBackedUpAt => $composableBuilder(
    column: $table.lastBackedUpAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<FileStatus, FileStatus, int> get lastStatus =>
      $composableBuilder(
        column: $table.lastStatus,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  $$JobsTableFilterComposer get jobId {
    final $$JobsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jobId,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableFilterComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> fileRunLogsRefs(
    Expression<bool> Function($$FileRunLogsTableFilterComposer f) f,
  ) {
    final $$FileRunLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fileRunLogs,
      getReferencedColumn: (t) => t.fileRecordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FileRunLogsTableFilterComposer(
            $db: $db,
            $table: $db.fileRunLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FileRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $FileRecordsTable> {
  $$FileRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nasPath => $composableBuilder(
    column: $table.nasPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hash => $composableBuilder(
    column: $table.hash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastBackedUpAt => $composableBuilder(
    column: $table.lastBackedUpAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastStatus => $composableBuilder(
    column: $table.lastStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$JobsTableOrderingComposer get jobId {
    final $$JobsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jobId,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableOrderingComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FileRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FileRecordsTable> {
  $$FileRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nasPath =>
      $composableBuilder(column: $table.nasPath, builder: (column) => column);

  GeneratedColumn<int> get sizeBytes =>
      $composableBuilder(column: $table.sizeBytes, builder: (column) => column);

  GeneratedColumn<DateTime> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => column,
  );

  GeneratedColumn<String> get hash =>
      $composableBuilder(column: $table.hash, builder: (column) => column);

  GeneratedColumn<DateTime> get lastBackedUpAt => $composableBuilder(
    column: $table.lastBackedUpAt,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<FileStatus, int> get lastStatus =>
      $composableBuilder(
        column: $table.lastStatus,
        builder: (column) => column,
      );

  $$JobsTableAnnotationComposer get jobId {
    final $$JobsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jobId,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableAnnotationComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> fileRunLogsRefs<T extends Object>(
    Expression<T> Function($$FileRunLogsTableAnnotationComposer a) f,
  ) {
    final $$FileRunLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fileRunLogs,
      getReferencedColumn: (t) => t.fileRecordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FileRunLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.fileRunLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FileRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FileRecordsTable,
          FileRecord,
          $$FileRecordsTableFilterComposer,
          $$FileRecordsTableOrderingComposer,
          $$FileRecordsTableAnnotationComposer,
          $$FileRecordsTableCreateCompanionBuilder,
          $$FileRecordsTableUpdateCompanionBuilder,
          (FileRecord, $$FileRecordsTableReferences),
          FileRecord,
          PrefetchHooks Function({bool jobId, bool fileRunLogsRefs})
        > {
  $$FileRecordsTableTableManager(_$AppDatabase db, $FileRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FileRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FileRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FileRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> jobId = const Value.absent(),
                Value<String> relativePath = const Value.absent(),
                Value<String> nasPath = const Value.absent(),
                Value<int> sizeBytes = const Value.absent(),
                Value<DateTime> lastModified = const Value.absent(),
                Value<String?> hash = const Value.absent(),
                Value<DateTime?> lastBackedUpAt = const Value.absent(),
                Value<FileStatus> lastStatus = const Value.absent(),
              }) => FileRecordsCompanion(
                id: id,
                jobId: jobId,
                relativePath: relativePath,
                nasPath: nasPath,
                sizeBytes: sizeBytes,
                lastModified: lastModified,
                hash: hash,
                lastBackedUpAt: lastBackedUpAt,
                lastStatus: lastStatus,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int jobId,
                required String relativePath,
                required String nasPath,
                required int sizeBytes,
                required DateTime lastModified,
                Value<String?> hash = const Value.absent(),
                Value<DateTime?> lastBackedUpAt = const Value.absent(),
                required FileStatus lastStatus,
              }) => FileRecordsCompanion.insert(
                id: id,
                jobId: jobId,
                relativePath: relativePath,
                nasPath: nasPath,
                sizeBytes: sizeBytes,
                lastModified: lastModified,
                hash: hash,
                lastBackedUpAt: lastBackedUpAt,
                lastStatus: lastStatus,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FileRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({jobId = false, fileRunLogsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (fileRunLogsRefs) db.fileRunLogs],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (jobId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.jobId,
                                referencedTable: $$FileRecordsTableReferences
                                    ._jobIdTable(db),
                                referencedColumn: $$FileRecordsTableReferences
                                    ._jobIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (fileRunLogsRefs)
                    await $_getPrefetchedData<
                      FileRecord,
                      $FileRecordsTable,
                      FileRunLog
                    >(
                      currentTable: table,
                      referencedTable: $$FileRecordsTableReferences
                          ._fileRunLogsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$FileRecordsTableReferences(
                            db,
                            table,
                            p0,
                          ).fileRunLogsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.fileRecordId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$FileRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FileRecordsTable,
      FileRecord,
      $$FileRecordsTableFilterComposer,
      $$FileRecordsTableOrderingComposer,
      $$FileRecordsTableAnnotationComposer,
      $$FileRecordsTableCreateCompanionBuilder,
      $$FileRecordsTableUpdateCompanionBuilder,
      (FileRecord, $$FileRecordsTableReferences),
      FileRecord,
      PrefetchHooks Function({bool jobId, bool fileRunLogsRefs})
    >;
typedef $$FileRunLogsTableCreateCompanionBuilder =
    FileRunLogsCompanion Function({
      Value<int> id,
      required int runId,
      Value<int?> fileRecordId,
      required FileAction action,
      required String filePath,
      Value<String?> errorMessage,
      required DateTime occurredAt,
    });
typedef $$FileRunLogsTableUpdateCompanionBuilder =
    FileRunLogsCompanion Function({
      Value<int> id,
      Value<int> runId,
      Value<int?> fileRecordId,
      Value<FileAction> action,
      Value<String> filePath,
      Value<String?> errorMessage,
      Value<DateTime> occurredAt,
    });

final class $$FileRunLogsTableReferences
    extends BaseReferences<_$AppDatabase, $FileRunLogsTable, FileRunLog> {
  $$FileRunLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $JobRunsTable _runIdTable(_$AppDatabase db) => db.jobRuns.createAlias(
    $_aliasNameGenerator(db.fileRunLogs.runId, db.jobRuns.id),
  );

  $$JobRunsTableProcessedTableManager get runId {
    final $_column = $_itemColumn<int>('run_id')!;

    final manager = $$JobRunsTableTableManager(
      $_db,
      $_db.jobRuns,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_runIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $FileRecordsTable _fileRecordIdTable(_$AppDatabase db) =>
      db.fileRecords.createAlias(
        $_aliasNameGenerator(db.fileRunLogs.fileRecordId, db.fileRecords.id),
      );

  $$FileRecordsTableProcessedTableManager? get fileRecordId {
    final $_column = $_itemColumn<int>('file_record_id');
    if ($_column == null) return null;
    final manager = $$FileRecordsTableTableManager(
      $_db,
      $_db.fileRecords,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fileRecordIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FileRunLogsTableFilterComposer
    extends Composer<_$AppDatabase, $FileRunLogsTable> {
  $$FileRunLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<FileAction, FileAction, int> get action =>
      $composableBuilder(
        column: $table.action,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  $$JobRunsTableFilterComposer get runId {
    final $$JobRunsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.runId,
      referencedTable: $db.jobRuns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobRunsTableFilterComposer(
            $db: $db,
            $table: $db.jobRuns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FileRecordsTableFilterComposer get fileRecordId {
    final $$FileRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fileRecordId,
      referencedTable: $db.fileRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FileRecordsTableFilterComposer(
            $db: $db,
            $table: $db.fileRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FileRunLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $FileRunLogsTable> {
  $$FileRunLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$JobRunsTableOrderingComposer get runId {
    final $$JobRunsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.runId,
      referencedTable: $db.jobRuns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobRunsTableOrderingComposer(
            $db: $db,
            $table: $db.jobRuns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FileRecordsTableOrderingComposer get fileRecordId {
    final $$FileRecordsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fileRecordId,
      referencedTable: $db.fileRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FileRecordsTableOrderingComposer(
            $db: $db,
            $table: $db.fileRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FileRunLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FileRunLogsTable> {
  $$FileRunLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<FileAction, int> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  $$JobRunsTableAnnotationComposer get runId {
    final $$JobRunsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.runId,
      referencedTable: $db.jobRuns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobRunsTableAnnotationComposer(
            $db: $db,
            $table: $db.jobRuns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FileRecordsTableAnnotationComposer get fileRecordId {
    final $$FileRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fileRecordId,
      referencedTable: $db.fileRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FileRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.fileRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FileRunLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FileRunLogsTable,
          FileRunLog,
          $$FileRunLogsTableFilterComposer,
          $$FileRunLogsTableOrderingComposer,
          $$FileRunLogsTableAnnotationComposer,
          $$FileRunLogsTableCreateCompanionBuilder,
          $$FileRunLogsTableUpdateCompanionBuilder,
          (FileRunLog, $$FileRunLogsTableReferences),
          FileRunLog,
          PrefetchHooks Function({bool runId, bool fileRecordId})
        > {
  $$FileRunLogsTableTableManager(_$AppDatabase db, $FileRunLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FileRunLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FileRunLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FileRunLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> runId = const Value.absent(),
                Value<int?> fileRecordId = const Value.absent(),
                Value<FileAction> action = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
              }) => FileRunLogsCompanion(
                id: id,
                runId: runId,
                fileRecordId: fileRecordId,
                action: action,
                filePath: filePath,
                errorMessage: errorMessage,
                occurredAt: occurredAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int runId,
                Value<int?> fileRecordId = const Value.absent(),
                required FileAction action,
                required String filePath,
                Value<String?> errorMessage = const Value.absent(),
                required DateTime occurredAt,
              }) => FileRunLogsCompanion.insert(
                id: id,
                runId: runId,
                fileRecordId: fileRecordId,
                action: action,
                filePath: filePath,
                errorMessage: errorMessage,
                occurredAt: occurredAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FileRunLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({runId = false, fileRecordId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (runId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.runId,
                                referencedTable: $$FileRunLogsTableReferences
                                    ._runIdTable(db),
                                referencedColumn: $$FileRunLogsTableReferences
                                    ._runIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (fileRecordId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.fileRecordId,
                                referencedTable: $$FileRunLogsTableReferences
                                    ._fileRecordIdTable(db),
                                referencedColumn: $$FileRunLogsTableReferences
                                    ._fileRecordIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FileRunLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FileRunLogsTable,
      FileRunLog,
      $$FileRunLogsTableFilterComposer,
      $$FileRunLogsTableOrderingComposer,
      $$FileRunLogsTableAnnotationComposer,
      $$FileRunLogsTableCreateCompanionBuilder,
      $$FileRunLogsTableUpdateCompanionBuilder,
      (FileRunLog, $$FileRunLogsTableReferences),
      FileRunLog,
      PrefetchHooks Function({bool runId, bool fileRecordId})
    >;
typedef $$InProgressUploadsTableCreateCompanionBuilder =
    InProgressUploadsCompanion Function({
      Value<int> id,
      required int jobId,
      required String localPath,
      required String nasTempPath,
      required String nasFinalPath,
      Value<int> bytesUploaded,
      required int totalBytes,
      required DateTime startedAt,
    });
typedef $$InProgressUploadsTableUpdateCompanionBuilder =
    InProgressUploadsCompanion Function({
      Value<int> id,
      Value<int> jobId,
      Value<String> localPath,
      Value<String> nasTempPath,
      Value<String> nasFinalPath,
      Value<int> bytesUploaded,
      Value<int> totalBytes,
      Value<DateTime> startedAt,
    });

final class $$InProgressUploadsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $InProgressUploadsTable,
          InProgressUpload
        > {
  $$InProgressUploadsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $JobsTable _jobIdTable(_$AppDatabase db) => db.jobs.createAlias(
    $_aliasNameGenerator(db.inProgressUploads.jobId, db.jobs.id),
  );

  $$JobsTableProcessedTableManager get jobId {
    final $_column = $_itemColumn<int>('job_id')!;

    final manager = $$JobsTableTableManager(
      $_db,
      $_db.jobs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_jobIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InProgressUploadsTableFilterComposer
    extends Composer<_$AppDatabase, $InProgressUploadsTable> {
  $$InProgressUploadsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nasTempPath => $composableBuilder(
    column: $table.nasTempPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nasFinalPath => $composableBuilder(
    column: $table.nasFinalPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bytesUploaded => $composableBuilder(
    column: $table.bytesUploaded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalBytes => $composableBuilder(
    column: $table.totalBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$JobsTableFilterComposer get jobId {
    final $$JobsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jobId,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableFilterComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InProgressUploadsTableOrderingComposer
    extends Composer<_$AppDatabase, $InProgressUploadsTable> {
  $$InProgressUploadsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nasTempPath => $composableBuilder(
    column: $table.nasTempPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nasFinalPath => $composableBuilder(
    column: $table.nasFinalPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bytesUploaded => $composableBuilder(
    column: $table.bytesUploaded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalBytes => $composableBuilder(
    column: $table.totalBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$JobsTableOrderingComposer get jobId {
    final $$JobsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jobId,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableOrderingComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InProgressUploadsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InProgressUploadsTable> {
  $$InProgressUploadsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<String> get nasTempPath => $composableBuilder(
    column: $table.nasTempPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nasFinalPath => $composableBuilder(
    column: $table.nasFinalPath,
    builder: (column) => column,
  );

  GeneratedColumn<int> get bytesUploaded => $composableBuilder(
    column: $table.bytesUploaded,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalBytes => $composableBuilder(
    column: $table.totalBytes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  $$JobsTableAnnotationComposer get jobId {
    final $$JobsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jobId,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableAnnotationComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InProgressUploadsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InProgressUploadsTable,
          InProgressUpload,
          $$InProgressUploadsTableFilterComposer,
          $$InProgressUploadsTableOrderingComposer,
          $$InProgressUploadsTableAnnotationComposer,
          $$InProgressUploadsTableCreateCompanionBuilder,
          $$InProgressUploadsTableUpdateCompanionBuilder,
          (InProgressUpload, $$InProgressUploadsTableReferences),
          InProgressUpload,
          PrefetchHooks Function({bool jobId})
        > {
  $$InProgressUploadsTableTableManager(
    _$AppDatabase db,
    $InProgressUploadsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InProgressUploadsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InProgressUploadsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InProgressUploadsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> jobId = const Value.absent(),
                Value<String> localPath = const Value.absent(),
                Value<String> nasTempPath = const Value.absent(),
                Value<String> nasFinalPath = const Value.absent(),
                Value<int> bytesUploaded = const Value.absent(),
                Value<int> totalBytes = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
              }) => InProgressUploadsCompanion(
                id: id,
                jobId: jobId,
                localPath: localPath,
                nasTempPath: nasTempPath,
                nasFinalPath: nasFinalPath,
                bytesUploaded: bytesUploaded,
                totalBytes: totalBytes,
                startedAt: startedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int jobId,
                required String localPath,
                required String nasTempPath,
                required String nasFinalPath,
                Value<int> bytesUploaded = const Value.absent(),
                required int totalBytes,
                required DateTime startedAt,
              }) => InProgressUploadsCompanion.insert(
                id: id,
                jobId: jobId,
                localPath: localPath,
                nasTempPath: nasTempPath,
                nasFinalPath: nasFinalPath,
                bytesUploaded: bytesUploaded,
                totalBytes: totalBytes,
                startedAt: startedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InProgressUploadsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({jobId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (jobId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.jobId,
                                referencedTable:
                                    $$InProgressUploadsTableReferences
                                        ._jobIdTable(db),
                                referencedColumn:
                                    $$InProgressUploadsTableReferences
                                        ._jobIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$InProgressUploadsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InProgressUploadsTable,
      InProgressUpload,
      $$InProgressUploadsTableFilterComposer,
      $$InProgressUploadsTableOrderingComposer,
      $$InProgressUploadsTableAnnotationComposer,
      $$InProgressUploadsTableCreateCompanionBuilder,
      $$InProgressUploadsTableUpdateCompanionBuilder,
      (InProgressUpload, $$InProgressUploadsTableReferences),
      InProgressUpload,
      PrefetchHooks Function({bool jobId})
    >;
typedef $$GlobalSettingsTableCreateCompanionBuilder =
    GlobalSettingsCompanion Function({
      Value<int> id,
      Value<String> nasHost,
      Value<int> nasPort,
      Value<bool> useHttps,
      Value<String> nasUsername,
      Value<ComparisonMethod> defaultComparisonMethod,
      Value<CompressionType> defaultCompressionType,
      Value<int> spaceWarnThresholdGb,
      Value<int> notificationFlags,
      Value<String?> backupExportPath,
    });
typedef $$GlobalSettingsTableUpdateCompanionBuilder =
    GlobalSettingsCompanion Function({
      Value<int> id,
      Value<String> nasHost,
      Value<int> nasPort,
      Value<bool> useHttps,
      Value<String> nasUsername,
      Value<ComparisonMethod> defaultComparisonMethod,
      Value<CompressionType> defaultCompressionType,
      Value<int> spaceWarnThresholdGb,
      Value<int> notificationFlags,
      Value<String?> backupExportPath,
    });

class $$GlobalSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $GlobalSettingsTable> {
  $$GlobalSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nasHost => $composableBuilder(
    column: $table.nasHost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nasPort => $composableBuilder(
    column: $table.nasPort,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get useHttps => $composableBuilder(
    column: $table.useHttps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nasUsername => $composableBuilder(
    column: $table.nasUsername,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ComparisonMethod, ComparisonMethod, int>
  get defaultComparisonMethod => $composableBuilder(
    column: $table.defaultComparisonMethod,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<CompressionType, CompressionType, int>
  get defaultCompressionType => $composableBuilder(
    column: $table.defaultCompressionType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get spaceWarnThresholdGb => $composableBuilder(
    column: $table.spaceWarnThresholdGb,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get notificationFlags => $composableBuilder(
    column: $table.notificationFlags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get backupExportPath => $composableBuilder(
    column: $table.backupExportPath,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GlobalSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $GlobalSettingsTable> {
  $$GlobalSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nasHost => $composableBuilder(
    column: $table.nasHost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nasPort => $composableBuilder(
    column: $table.nasPort,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get useHttps => $composableBuilder(
    column: $table.useHttps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nasUsername => $composableBuilder(
    column: $table.nasUsername,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultComparisonMethod => $composableBuilder(
    column: $table.defaultComparisonMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultCompressionType => $composableBuilder(
    column: $table.defaultCompressionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get spaceWarnThresholdGb => $composableBuilder(
    column: $table.spaceWarnThresholdGb,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get notificationFlags => $composableBuilder(
    column: $table.notificationFlags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get backupExportPath => $composableBuilder(
    column: $table.backupExportPath,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GlobalSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GlobalSettingsTable> {
  $$GlobalSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nasHost =>
      $composableBuilder(column: $table.nasHost, builder: (column) => column);

  GeneratedColumn<int> get nasPort =>
      $composableBuilder(column: $table.nasPort, builder: (column) => column);

  GeneratedColumn<bool> get useHttps =>
      $composableBuilder(column: $table.useHttps, builder: (column) => column);

  GeneratedColumn<String> get nasUsername => $composableBuilder(
    column: $table.nasUsername,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<ComparisonMethod, int>
  get defaultComparisonMethod => $composableBuilder(
    column: $table.defaultComparisonMethod,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<CompressionType, int>
  get defaultCompressionType => $composableBuilder(
    column: $table.defaultCompressionType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get spaceWarnThresholdGb => $composableBuilder(
    column: $table.spaceWarnThresholdGb,
    builder: (column) => column,
  );

  GeneratedColumn<int> get notificationFlags => $composableBuilder(
    column: $table.notificationFlags,
    builder: (column) => column,
  );

  GeneratedColumn<String> get backupExportPath => $composableBuilder(
    column: $table.backupExportPath,
    builder: (column) => column,
  );
}

class $$GlobalSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GlobalSettingsTable,
          GlobalSetting,
          $$GlobalSettingsTableFilterComposer,
          $$GlobalSettingsTableOrderingComposer,
          $$GlobalSettingsTableAnnotationComposer,
          $$GlobalSettingsTableCreateCompanionBuilder,
          $$GlobalSettingsTableUpdateCompanionBuilder,
          (
            GlobalSetting,
            BaseReferences<_$AppDatabase, $GlobalSettingsTable, GlobalSetting>,
          ),
          GlobalSetting,
          PrefetchHooks Function()
        > {
  $$GlobalSettingsTableTableManager(
    _$AppDatabase db,
    $GlobalSettingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GlobalSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GlobalSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GlobalSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nasHost = const Value.absent(),
                Value<int> nasPort = const Value.absent(),
                Value<bool> useHttps = const Value.absent(),
                Value<String> nasUsername = const Value.absent(),
                Value<ComparisonMethod> defaultComparisonMethod =
                    const Value.absent(),
                Value<CompressionType> defaultCompressionType =
                    const Value.absent(),
                Value<int> spaceWarnThresholdGb = const Value.absent(),
                Value<int> notificationFlags = const Value.absent(),
                Value<String?> backupExportPath = const Value.absent(),
              }) => GlobalSettingsCompanion(
                id: id,
                nasHost: nasHost,
                nasPort: nasPort,
                useHttps: useHttps,
                nasUsername: nasUsername,
                defaultComparisonMethod: defaultComparisonMethod,
                defaultCompressionType: defaultCompressionType,
                spaceWarnThresholdGb: spaceWarnThresholdGb,
                notificationFlags: notificationFlags,
                backupExportPath: backupExportPath,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nasHost = const Value.absent(),
                Value<int> nasPort = const Value.absent(),
                Value<bool> useHttps = const Value.absent(),
                Value<String> nasUsername = const Value.absent(),
                Value<ComparisonMethod> defaultComparisonMethod =
                    const Value.absent(),
                Value<CompressionType> defaultCompressionType =
                    const Value.absent(),
                Value<int> spaceWarnThresholdGb = const Value.absent(),
                Value<int> notificationFlags = const Value.absent(),
                Value<String?> backupExportPath = const Value.absent(),
              }) => GlobalSettingsCompanion.insert(
                id: id,
                nasHost: nasHost,
                nasPort: nasPort,
                useHttps: useHttps,
                nasUsername: nasUsername,
                defaultComparisonMethod: defaultComparisonMethod,
                defaultCompressionType: defaultCompressionType,
                spaceWarnThresholdGb: spaceWarnThresholdGb,
                notificationFlags: notificationFlags,
                backupExportPath: backupExportPath,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GlobalSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GlobalSettingsTable,
      GlobalSetting,
      $$GlobalSettingsTableFilterComposer,
      $$GlobalSettingsTableOrderingComposer,
      $$GlobalSettingsTableAnnotationComposer,
      $$GlobalSettingsTableCreateCompanionBuilder,
      $$GlobalSettingsTableUpdateCompanionBuilder,
      (
        GlobalSetting,
        BaseReferences<_$AppDatabase, $GlobalSettingsTable, GlobalSetting>,
      ),
      GlobalSetting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$JobsTableTableManager get jobs => $$JobsTableTableManager(_db, _db.jobs);
  $$JobRunsTableTableManager get jobRuns =>
      $$JobRunsTableTableManager(_db, _db.jobRuns);
  $$FileRecordsTableTableManager get fileRecords =>
      $$FileRecordsTableTableManager(_db, _db.fileRecords);
  $$FileRunLogsTableTableManager get fileRunLogs =>
      $$FileRunLogsTableTableManager(_db, _db.fileRunLogs);
  $$InProgressUploadsTableTableManager get inProgressUploads =>
      $$InProgressUploadsTableTableManager(_db, _db.inProgressUploads);
  $$GlobalSettingsTableTableManager get globalSettings =>
      $$GlobalSettingsTableTableManager(_db, _db.globalSettings);
}
