import 'package:flutter/services.dart';

class SafService {
  static const _channel =
      MethodChannel('com.clipclapclop.backupofrecord/saf');

  /// Opens the system folder picker. Returns a persistent SAF URI string,
  /// or null if the user cancelled.
  static Future<String?> pickFolder() =>
      _channel.invokeMethod<String>('pickFolder');

  /// Writes [bytes] as [fileName] into the SAF folder [uri].
  static Future<void> writeFile(
          String uri, String fileName, Uint8List bytes) =>
      _channel.invokeMethod<void>(
          'writeFile', {'uri': uri, 'fileName': fileName, 'bytes': bytes});

  /// Returns a human-readable label for a SAF tree URI.
  /// e.g. "content://…/tree/primary%3ADownload" → "Download"
  static String displayName(String safUri) {
    try {
      final decoded = Uri.decodeFull(safUri);
      final parts = decoded.split(':');
      if (parts.length >= 2) return parts.last.split('/').last;
    } catch (_) {}
    return safUri;
  }
}
