import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

/// A file or directory entry returned from a PROPFIND listing.
class WebDavEntry {
  final String name;
  final String path; // absolute path on server, e.g. /backups/photos/
  final bool isDirectory;
  final int contentLength;
  final DateTime? lastModified;

  const WebDavEntry({
    required this.name,
    required this.path,
    required this.isDirectory,
    required this.contentLength,
    this.lastModified,
  });

  @override
  String toString() =>
      'WebDavEntry(name: $name, isDir: $isDirectory, size: $contentLength)';
}

/// Low-level WebDAV client.
///
/// Supports HTTPS with cert verification disabled (self-signed NAS certs)
/// or plain HTTP, based on [useHttps].
///
/// All [path] arguments should be absolute server paths, e.g. `/backups/photos`.
class WebDavService {
  final String host;
  final int port;
  final bool useHttps;
  final String username;
  final String password;

  final http.Client _client;

  WebDavService({
    required this.host,
    required this.port,
    required this.useHttps,
    required this.username,
    required this.password,
  }) : _client = useHttps ? _buildPermissiveHttpsClient() : http.Client();

  static http.Client _buildPermissiveHttpsClient() {
    final ioClient = HttpClient()
      ..badCertificateCallback = (cert, host, port) => true;
    return _IOHttpClient(ioClient);
  }

  String get _base => '${useHttps ? 'https' : 'http'}://$host:$port';

  Map<String, String> get _auth => {
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$username:$password'))}',
      };

  Uri _uri(String path) => Uri(
        scheme: useHttps ? 'https' : 'http',
        host: host,
        port: port,
        path: path,
      );

  // ── Connection test ────────────────────────────────────────────────────────

  /// Returns true if the NAS responds to a PROPFIND on the WebDAV root.
  Future<bool> testConnection() async {
    try {
      final req = http.Request('PROPFIND', _uri('/'))
        ..headers.addAll({..._auth, 'Depth': '0'});
      final res = await _client.send(req);
      return res.statusCode == 207 || res.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  // ── Directory listing ──────────────────────────────────────────────────────

  /// Lists the contents of [path] on the NAS (non-recursive, Depth: 1).
  /// The directory entry itself is excluded from results.
  Future<List<WebDavEntry>> listDirectory(String path) async {
    final normalised = _ensureLeadingSlash(path);
    final req = http.Request('PROPFIND', _uri(normalised))
      ..headers.addAll({
        ..._auth,
        'Depth': '1',
        'Content-Type': 'application/xml; charset=utf-8',
      })
      ..body = '''<?xml version="1.0" encoding="utf-8"?>
<D:propfind xmlns:D="DAV:">
  <D:prop>
    <D:displayname/>
    <D:getcontentlength/>
    <D:getlastmodified/>
    <D:resourcetype/>
  </D:prop>
</D:propfind>''';

    final res = await _client.send(req);
    if (res.statusCode != 207) {
      throw WebDavException('PROPFIND $path → ${res.statusCode}');
    }
    final body = await res.stream.bytesToString();
    final entries = _parseMultistatus(body);

    // Skip the first entry — it's the directory itself
    final selfPath = normalised.endsWith('/') ? normalised : '$normalised/';
    return entries
        .where((e) =>
            Uri.decodeComponent(e.path) != selfPath &&
            Uri.decodeComponent(e.path) != normalised)
        .toList();
  }

  // ── File existence check ───────────────────────────────────────────────────

  /// Returns true if the file or directory at [path] exists on the NAS.
  Future<bool> exists(String path) async {
    final req = http.Request('PROPFIND', _uri(_ensureLeadingSlash(path)))
      ..headers.addAll({..._auth, 'Depth': '0'});
    try {
      final res = await _client.send(req);
      await res.stream.drain<void>();
      return res.statusCode == 207 || res.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  // ── Directory creation ─────────────────────────────────────────────────────

  /// Creates [path] on the NAS, including all missing parent directories.
  Future<void> createDirectoryIfNeeded(String path) async {
    final parts = _ensureLeadingSlash(path)
        .split('/')
        .where((p) => p.isNotEmpty)
        .toList();

    String current = '';
    for (final part in parts) {
      current += '/$part';
      final req = http.Request('MKCOL', _uri(current))
        ..headers.addAll(_auth);
      final res = await _client.send(req);
      await res.stream.drain<void>();
      // 201 = created, 405 = already exists — both are fine
      if (res.statusCode != 201 && res.statusCode != 405) {
        throw WebDavException('MKCOL $current → ${res.statusCode}');
      }
    }
  }

  // ── File upload ────────────────────────────────────────────────────────────

  /// Uploads [localFile] to [remotePath] on the NAS using a `.part` staging
  /// file (written first, then renamed) for crash safety.
  ///
  /// [onProgress] receives (bytesUploaded, totalBytes) as the upload proceeds.
  Future<void> uploadFile(
    File localFile,
    String remotePath, {
    void Function(int sent, int total)? onProgress,
  }) async {
    final partPath = '$remotePath.part';
    final total = await localFile.length();

    // Ensure parent directory exists
    final parent = _parentPath(remotePath);
    if (parent.isNotEmpty) await createDirectoryIfNeeded(parent);

    // Stream upload to .part file
    await _putStream(
      localFile.openRead(),
      partPath,
      total,
      onProgress: onProgress,
    );

    // Rename .part → final path
    await move(partPath, remotePath);
  }

  /// Uploads raw [bytes] to [remotePath]. For small in-memory payloads.
  Future<void> uploadBytes(List<int> bytes, String remotePath) async {
    final partPath = '$remotePath.part';
    final parent = _parentPath(remotePath);
    if (parent.isNotEmpty) await createDirectoryIfNeeded(parent);

    await _putBytes(bytes, partPath);
    await move(partPath, remotePath);
  }

  Future<void> _putStream(
    Stream<List<int>> source,
    String remotePath,
    int contentLength, {
    void Function(int sent, int total)? onProgress,
  }) async {
    Stream<List<int>> body = source;
    if (onProgress != null) {
      int sent = 0;
      body = source.map((chunk) {
        sent += chunk.length;
        onProgress(sent, contentLength);
        return chunk;
      });
    }

    final req =
        _DirectStreamRequest('PUT', _uri(_ensureLeadingSlash(remotePath)), body)
          ..headers.addAll(
              {..._auth, 'Content-Type': 'application/octet-stream'})
          ..contentLength = contentLength;

    final res = await _client.send(req);
    await res.stream.drain<void>();
    if (res.statusCode != 201 && res.statusCode != 204) {
      throw WebDavException('PUT $remotePath → ${res.statusCode}');
    }
  }

  Future<void> _putBytes(List<int> bytes, String remotePath) async {
    final req = http.Request('PUT', _uri(_ensureLeadingSlash(remotePath)))
      ..headers.addAll({..._auth, 'Content-Type': 'application/octet-stream'})
      ..bodyBytes = bytes;
    final res = await _client.send(req);
    await res.stream.drain<void>();
    if (res.statusCode != 201 && res.statusCode != 204) {
      throw WebDavException('PUT $remotePath → ${res.statusCode}');
    }
  }

  // ── Move / Delete ──────────────────────────────────────────────────────────

  /// Moves/renames [fromPath] to [toPath] on the NAS.
  Future<void> move(String fromPath, String toPath) async {
    final destination =
        '$_base${_ensureLeadingSlash(toPath)}';
    final req =
        http.Request('MOVE', _uri(_ensureLeadingSlash(fromPath)))
          ..headers.addAll({
            ..._auth,
            'Destination': destination,
            'Overwrite': 'T',
          });
    final res = await _client.send(req);
    await res.stream.drain<void>();
    if (res.statusCode != 201 && res.statusCode != 204) {
      throw WebDavException('MOVE $fromPath → $toPath : ${res.statusCode}');
    }
  }

  /// Deletes the file or directory at [remotePath] on the NAS.
  Future<void> delete(String remotePath) async {
    final req = http.Request('DELETE', _uri(_ensureLeadingSlash(remotePath)))
      ..headers.addAll(_auth);
    final res = await _client.send(req);
    await res.stream.drain<void>();
    if (res.statusCode != 200 &&
        res.statusCode != 204 &&
        res.statusCode != 404) {
      throw WebDavException('DELETE $remotePath → ${res.statusCode}');
    }
  }

  /// Removes a stale `.part` file if it exists (best-effort, ignores errors).
  Future<void> deletePart(String finalRemotePath) async {
    try {
      await delete('$finalRemotePath.part');
    } catch (_) {}
  }

  // ── File download ──────────────────────────────────────────────────────────

  /// Downloads [remotePath] from the NAS and writes it to [localPath].
  /// [onProgress] receives (bytesReceived, totalBytes) during download.
  Future<void> downloadFile(
    String remotePath,
    String localPath, {
    void Function(int received, int total)? onProgress,
  }) async {
    final req = http.Request('GET', _uri(_ensureLeadingSlash(remotePath)))
      ..headers.addAll(_auth);
    final res = await _client.send(req);
    if (res.statusCode != 200) {
      await res.stream.drain<void>();
      throw WebDavException('GET $remotePath → ${res.statusCode}');
    }

    final total = res.contentLength ?? 0;
    final sink = File(localPath).openWrite();
    int received = 0;
    await res.stream.forEach((chunk) {
      sink.add(chunk);
      received += chunk.length;
      onProgress?.call(received, total);
    });
    await sink.close();
  }

  // ── Storage quota ──────────────────────────────────────────────────────────

  /// Returns available bytes on the NAS, or null if not reported.
  Future<int?> getAvailableBytes() async {
    final req = http.Request('PROPFIND', _uri('/'))
      ..headers.addAll({
        ..._auth,
        'Depth': '0',
        'Content-Type': 'application/xml; charset=utf-8',
      })
      ..body = '''<?xml version="1.0" encoding="utf-8"?>
<D:propfind xmlns:D="DAV:">
  <D:prop>
    <D:quota-available-bytes/>
  </D:prop>
</D:propfind>''';

    try {
      final res = await _client.send(req);
      final body = await res.stream.bytesToString();
      final raw = _extractTag(body, 'quota-available-bytes');
      return int.tryParse(raw);
    } catch (_) {
      return null;
    }
  }

  // ── XML parsing ────────────────────────────────────────────────────────────

  List<WebDavEntry> _parseMultistatus(String body) {
    // Strip all namespace prefixes so tags become simple names.
    final stripped = body.replaceAllMapped(
        RegExp(r'<(/?)[a-zA-Z][a-zA-Z0-9]*:'), (m) => '<${m[1]}');

    final responses = RegExp(
      r'<response>(.*?)</response>',
      dotAll: true,
    ).allMatches(stripped);

    final entries = <WebDavEntry>[];
    for (final m in responses) {
      final block = m.group(1)!;
      final rawHref = Uri.decodeFull(_extractTag(block, 'href').trim());
      if (rawHref.isEmpty) continue;

      final isDir = block.contains('<collection');
      final name = _nameFromHref(rawHref);
      final size = int.tryParse(_extractTag(block, 'getcontentlength')) ?? 0;
      final lastModStr = _extractTag(block, 'getlastmodified');
      DateTime? lastMod;
      if (lastModStr.isNotEmpty) {
        try {
          lastMod = HttpDate.parse(lastModStr);
        } catch (_) {}
      }

      entries.add(WebDavEntry(
        name: name,
        path: rawHref,
        isDirectory: isDir,
        contentLength: size,
        lastModified: lastMod,
      ));
    }
    return entries;
  }

  String _extractTag(String xml, String tag) {
    final match =
        RegExp('<$tag[^>]*>(.*?)</$tag>', dotAll: true).firstMatch(xml);
    return match?.group(1)?.trim() ?? '';
  }

  String _nameFromHref(String href) {
    final trimmed = href.endsWith('/') ? href.substring(0, href.length - 1) : href;
    final idx = trimmed.lastIndexOf('/');
    return idx >= 0 ? trimmed.substring(idx + 1) : trimmed;
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  String _ensureLeadingSlash(String path) =>
      path.startsWith('/') ? path : '/$path';

  String _parentPath(String path) {
    final trimmed =
        path.endsWith('/') ? path.substring(0, path.length - 1) : path;
    final idx = trimmed.lastIndexOf('/');
    if (idx <= 0) return '';
    return trimmed.substring(0, idx);
  }

  void dispose() => _client.close();
}

// ── WebDavException ────────────────────────────────────────────────────────────

class WebDavException implements Exception {
  final String message;
  const WebDavException(this.message);
  @override
  String toString() => 'WebDavException: $message';
}

// ── _DirectStreamRequest ───────────────────────────────────────────────────────

/// A [http.BaseRequest] that wraps a pre-built [Stream] as the body.
/// [finalize] simply passes the stream straight through — no intermediate
/// controller needed, so there is no risk of the sink closing prematurely.
class _DirectStreamRequest extends http.BaseRequest {
  final Stream<List<int>> _stream;

  _DirectStreamRequest(super.method, super.url, this._stream);

  @override
  http.ByteStream finalize() {
    super.finalize();
    return http.ByteStream(_stream);
  }
}

// ── _IOHttpClient ──────────────────────────────────────────────────────────────

/// Wraps dart:io [HttpClient] as an [http.Client] so we can disable TLS
/// certificate verification (accepting self-signed NAS certs).
class _IOHttpClient extends http.BaseClient {
  final HttpClient _inner;
  _IOHttpClient(this._inner);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final ioReq = await _inner.openUrl(request.method, request.url);
    request.headers.forEach(ioReq.headers.set);

    if (request.contentLength != null && request.contentLength! >= 0) {
      ioReq.contentLength = request.contentLength!;
    }

    final body = request.finalize();
    await ioReq.addStream(body);

    final ioRes = await ioReq.close();
    final headers = <String, String>{};
    ioRes.headers.forEach((k, vs) => headers[k] = vs.join(','));

    return http.StreamedResponse(
      ioRes,
      ioRes.statusCode,
      contentLength: ioRes.contentLength < 0 ? null : ioRes.contentLength,
      headers: headers,
    );
  }

  @override
  void close() => _inner.close(force: true);
}
