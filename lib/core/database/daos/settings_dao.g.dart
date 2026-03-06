// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_dao.dart';

// ignore_for_file: type=lint
mixin _$SettingsDaoMixin on DatabaseAccessor<AppDatabase> {
  $GlobalSettingsTable get globalSettings => attachedDatabase.globalSettings;
  SettingsDaoManager get managers => SettingsDaoManager(this);
}

class SettingsDaoManager {
  final _$SettingsDaoMixin _db;
  SettingsDaoManager(this._db);
  $$GlobalSettingsTableTableManager get globalSettings =>
      $$GlobalSettingsTableTableManager(
        _db.attachedDatabase,
        _db.globalSettings,
      );
}
