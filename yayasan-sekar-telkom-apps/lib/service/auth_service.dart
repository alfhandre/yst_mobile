// auth_service.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static final _storage = FlutterSecureStorage();

  static Future<bool> isUserLoggedIn() async {
    // Check if a token is present in secure storage
    String? token = await _storage.read(key: 'token');
    return token != null;
  }
}
