import 'package:shared_preferences/shared_preferences.dart';

import 'api_models.dart';

class AuthSession {
  static const _kAccessToken = 'auth_access_token';
  static const _kRefreshToken = 'auth_refresh_token';
  static const _kTokenType = 'auth_token_type';
  static const _kUserEmail = 'auth_user_email';

  static String? _accessToken;
  static String? _refreshToken;
  static String _tokenType = 'Bearer';
  static String? _userEmail;

  static bool get isLoggedIn => (_accessToken ?? '').isNotEmpty;
  static String? get accessToken => _accessToken;
  static String? get refreshToken => _refreshToken;
  static String get tokenType => _tokenType;
  static String? get userEmail => _userEmail;

  static String? get authorizationHeader {
    final access = _accessToken;
    if (access == null || access.isEmpty) return null;
    return '$_tokenType $access';
  }

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString(_kAccessToken);
    _refreshToken = prefs.getString(_kRefreshToken);
    _tokenType = prefs.getString(_kTokenType) ?? 'Bearer';
    _userEmail = prefs.getString(_kUserEmail);
  }

  static Future<void> saveTokenPair(TokenPair pair) async {
    _accessToken = pair.access;
    _refreshToken = pair.refresh;
    _tokenType = pair.tokenType.isNotEmpty ? pair.tokenType : 'Bearer';
    _userEmail = pair.user?['email'] as String?;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kAccessToken, _accessToken ?? '');
    await prefs.setString(_kRefreshToken, _refreshToken ?? '');
    await prefs.setString(_kTokenType, _tokenType);
    if (_userEmail != null) {
      await prefs.setString(_kUserEmail, _userEmail!);
    } else {
      await prefs.remove(_kUserEmail);
    }
  }

  static Future<void> updateAccessToken({
    required String access,
    required String tokenType,
  }) async {
    _accessToken = access;
    _tokenType = tokenType.isNotEmpty ? tokenType : _tokenType;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kAccessToken, _accessToken ?? '');
    await prefs.setString(_kTokenType, _tokenType);
  }

  static Future<void> clear() async {
    _accessToken = null;
    _refreshToken = null;
    _tokenType = 'Bearer';
    _userEmail = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kAccessToken);
    await prefs.remove(_kRefreshToken);
    await prefs.remove(_kTokenType);
    await prefs.remove(_kUserEmail);
  }
}
