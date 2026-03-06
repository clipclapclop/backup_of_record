import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

/// Low-level WebDAV client.
///
/// Supports HTTPS with cert verification disabled (self-signed NAS certs)
/// or plain HTTP, based on [useHttps].
///
/// Full operations (chunked PUT, PROPFIND listing, MOVE, DELETE) will be
/// added as each backup feature is implemented.
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

  String get _baseUrl => '${useHttps ? 'https' : 'http'}://$host:$port';

  Map<String, String> get _authHeaders => {
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$username:$password'))}',
      };

  /// Returns true if the NAS responds to a PROPFIND on the WebDAV root.
  Future<bool> testConnection() async {
    try {
      final uri = Uri.parse('$_baseUrl/');
      final req = http.Request('PROPFIND', uri)
        ..headers.addAll({..._authHeaders, 'Depth': '0'});
      final response = await _client.send(req);
      return response.statusCode == 207 || response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  void dispose() => _client.close();
}

/// Wraps dart:io [HttpClient] as an [http.Client] so we can pass a permissive
/// SecurityContext (accepting self-signed certs) through the standard http API.
class _IOHttpClient extends http.BaseClient {
  final HttpClient _inner;
  _IOHttpClient(this._inner);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final ioRequest = await _inner.openUrl(request.method, request.url);
    request.headers.forEach(ioRequest.headers.set);
    if (request is http.Request && request.bodyBytes.isNotEmpty) {
      ioRequest.add(request.bodyBytes);
    }
    final ioResponse = await ioRequest.close();
    final headers = <String, String>{};
    ioResponse.headers.forEach((name, values) => headers[name] = values.join(','));
    return http.StreamedResponse(
      ioResponse,
      ioResponse.statusCode,
      headers: headers,
    );
  }

  @override
  void close() => _inner.close(force: true);
}
