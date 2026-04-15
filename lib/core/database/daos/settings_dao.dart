import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/global_settings_table.dart';

part 'settings_dao.g.dart';

@DriftAccessor(tables: [GlobalSettings])
class SettingsDao extends DatabaseAccessor<AppDatabase> with _$SettingsDaoMixin {
  SettingsDao(super.db);

  Future<GlobalSetting?> getSettings() =>
      (select(globalSettings)..where((s) => s.id.equals(1))).getSingleOrNull();

  /// Upserts settings and flips the auto-backup dirty flag unless the caller
  /// is explicitly writing that field itself (e.g. BackupEngine clearing it
  /// after a successful self-export).
  Future<void> upsertSettings(GlobalSettingsCompanion entry) {
    final withDirty = entry.autoBackupDirty.present
        ? entry
        : entry.copyWith(autoBackupDirty: const Value(true));
    return into(globalSettings).insertOnConflictUpdate(withDirty);
  }

  Future<void> markDirty() =>
      (update(globalSettings)..where((s) => s.id.equals(1))).write(
        const GlobalSettingsCompanion(autoBackupDirty: Value(true)),
      );

  Future<void> markCleanExported(DateTime at) =>
      (update(globalSettings)..where((s) => s.id.equals(1))).write(
        GlobalSettingsCompanion(
          autoBackupDirty: const Value(false),
          autoBackupLastExportAt: Value(at),
        ),
      );
}
