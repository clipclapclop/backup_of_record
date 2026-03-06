import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static const _keyNasPassword = 'nas_password';

  Future<void> saveNasPassword(String password) =>
      _storage.write(key: _keyNasPassword, value: password);

  Future<String?> getNasPassword() =>
      _storage.read(key: _keyNasPassword);

  Future<void> deleteNasPassword() =>
      _storage.delete(key: _keyNasPassword);
}
