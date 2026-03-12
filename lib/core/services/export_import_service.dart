import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../database/app_database.dart';

class ExportImportService {
  /// Returns the path to the live SQLite DB file on disk.
  Future<String> _dbFilePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return p.join(dir.path, 'backup_of_record.db');
  }

  /// Exports the full database as a zip to [destinationDir].
  ///
  /// Returns the path of the written zip file.
  Future<String> exportBackup(AppDatabase db, String destinationDir) async {
    // Flush WAL so the DB file on disk is current.
    await db.customStatement('PRAGMA wal_checkpoint(FULL)');

    final dbPath = await _dbFilePath();
    final dbBytes = await File(dbPath).readAsBytes();

    final metadata = jsonEncode({
      'version': 1,
      'exportedAt': DateTime.now().toIso8601String(),
      'excludedSecrets': ['nasPassword'],
    });
    final metaBytes = utf8.encode(metadata);

    final archive = Archive()
      ..addFile(ArchiveFile('backup_of_record.db', dbBytes.length, dbBytes))
      ..addFile(ArchiveFile('metadata.json', metaBytes.length, metaBytes));

    final zipBytes = ZipEncoder().encode(archive)!;

    final dateStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final filename = 'backup_of_record_$dateStr.zip';
    final outputPath = p.join(destinationDir, filename);
    await File(outputPath).writeAsBytes(zipBytes);

    return outputPath;
  }

  /// Imports a backup zip, fully replacing the existing database.
  ///
  /// Closes the DB, overwrites the file, then exits the process so the app
  /// restarts cleanly (all Drift / Riverpod state reinitialised on next launch).
  Future<void> importBackup(AppDatabase db, String zipFilePath) async {
    final zipBytes = await File(zipFilePath).readAsBytes();
    final archive = ZipDecoder().decodeBytes(zipBytes);

    final dbEntry = archive.files.firstWhere(
      (f) => f.name.endsWith('.db'),
      orElse: () => throw const FormatException('No .db file found in backup zip'),
    );

    final dbPath = await _dbFilePath();

    // Close Drift before touching the file.
    await db.close();

    await File(dbPath).writeAsBytes(dbEntry.content as List<int>);

    // Force full restart — cleanest way to reinitialise all state.
    exit(0);
  }
}
