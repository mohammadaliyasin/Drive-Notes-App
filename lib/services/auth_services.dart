import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

class AuthService {
  static const _clientId = 'YOUR_GOOGLE_CLIENT_ID.apps.googleusercontent.com';
  static const _scopes = [
    'https://www.googleapis.com/auth/drive.file',
    'https://www.googleapis.com/auth/userinfo.email',
  ];

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  AutoRefreshingAuthClient? _client;

  Future<bool> signInWithGoogle() async {
    try {
      final clientId = ClientId(_clientId, null);
      final client = await clientViaUserConsent(clientId, _scopes, (url) {
        // In actual app: launch URL in browser for user to consent
        print('Please go to the following URL and grant access:');
        print('  => $url');
      });

      _client = client;
      final credentials = client.credentials;
      await _storage.write(key: 'accessToken', value: credentials.accessToken.data);
      await _storage.write(key: 'expiry', value: credentials.accessToken.expiry.toIso8601String());
      await _storage.write(key: 'idToken', value: credentials.idToken);

      return true;
    } catch (e) {
      print('Sign-in error: $e');
      return false;
    }
  }

  Future<void> signOut() async {
    _client = null;
    await _storage.deleteAll();
  }

  AutoRefreshingAuthClient? get client => _client;
}
