import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/global_settings_table.dart';

part 'settings_dao.g.dart';

@DriftAccessor(tables: [GlobalSettings])
class SettingsDao extends DatabaseAccessor<AppDatabase> with _$SettingsDaoMixin {
  SettingsDao(super.db);

  Future<GlobalSetting?> getSettings() =>
      (select(globalSettings)..where((s) => s.id.equals(1))).getSingleOrNull();

  Future<void> upsertSettings(GlobalSettingsCompanion entry) =>
      into(globalSettings).insertOnConflictUpdate(entry);
}
