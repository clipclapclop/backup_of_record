import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../database/app_database.dart';
import 'saf_service.dart';

class ExportImportService {
  /// Builds the export zip and returns the raw bytes.
  /// The caller is responsible for writing/saving them (e.g. via FilePicker.saveFile).
  Future<Uint8List> buildExportZip(AppDatabase db) async {
    final tmpDir = await getTemporaryDirectory();
    final tmpDbPath = p.join(tmpDir.path, 'backup_export_tmp.sqlite');
    final tmpFile = File(tmpDbPath);

    if (await tmpFile.exists()) await tmpFile.delete();

    try {
      // VACUUM INTO creates a clean, WAL-flushed snapshot without needing
      // to know where drift stored the live database file.
      await db.customStatement("VACUUM INTO '$tmpDbPath'");

      final dbBytes = await tmpFile.readAsBytes();

      final metadata = jsonEncode({
        'version': 1,
        'exportedAt': DateTime.now().toIso8601String(),
        'excludedSecrets': ['nasPassword'],
      });
      final metaBytes = utf8.encode(metadata);

      final archive = Archive()
        ..addFile(ArchiveFile('backup_of_record.sqlite', dbBytes.length, dbBytes))
        ..addFile(ArchiveFile('metadata.json', metaBytes.length, metaBytes));

      return Uint8List.fromList(ZipEncoder().encode(archive)!);
    } finally {
      if (await tmpFile.exists()) await tmpFile.delete();
    }
  }

  /// Writes the export zip to the SAF folder URI the user previously picked.
  Future<void> writeToSaf(String safUri, Uint8List zipBytes) =>
      SafService.writeFile(safUri, 'backup_of_record_backup.zip', zipBytes);

  /// Imports a backup zip, fully replacing the existing database.
  ///
  /// Closes the DB, overwrites the file, then exits the process so the app
  /// restarts cleanly (all Drift / Riverpod state reinitialised on next launch).
  Future<void> importBackup(AppDatabase db, String zipFilePath) async {
    final zipBytes = await File(zipFilePath).readAsBytes();
    final archive = ZipDecoder().decodeBytes(zipBytes);

    final dbEntry = archive.files.firstWhere(
      (f) => f.name.endsWith('.sqlite') || f.name.endsWith('.db'),
      orElse: () => throw const FormatException('No database file found in backup zip'),
    );

    // drift_flutter default: getApplicationDocumentsDirectory() + name.sqlite
    final docsDir = await getApplicationDocumentsDirectory();
    final dbPath = p.join(docsDir.path, 'backup_of_record.sqlite');

    await db.close();
    await File(dbPath).writeAsBytes(dbEntry.content as List<int>);

    exit(0);
  }
}
