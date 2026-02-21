import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_models.dart';
import 'auth_session.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  const ApiException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

class ApiClient {
  ApiClient._();

  static final ApiClient instance = ApiClient._();

  static const String _host = 'api.maqsadtracker.uz';

  Future<TokenPair> login({
    required String email,
    required String password,
  }) async {
    final uri = Uri.https(_host, '/api/auth/login/');
    final response = await _safeRequest(
      http.post(
        uri,
        headers: _jsonHeaders,
        body: jsonEncode({'email': email, 'password': password}),
      ),
    );
    final body = _decode(response);
    _throwIfError(response, body);

    if (body is! Map<String, dynamic>) {
      throw const ApiException('Login response noto‘g‘ri formatda keldi');
    }
    final tokenPair = TokenPair.fromJson(body);
    await AuthSession.saveTokenPair(tokenPair);
    return tokenPair;
  }

  Future<Map<String, dynamic>> getMe() async {
    final response = await _sendAuthorized(
      (headers) =>
          http.get(Uri.https(_host, '/api/user/me/'), headers: headers),
    );
    final body = _decode(response);
    _throwIfError(response, body);
    if (body is! Map<String, dynamic>) {
      throw const ApiException('User response noto‘g‘ri formatda keldi');
    }
    return body;
  }

  Future<List<ApiHabit>> getHabits({
    DateTime? date,
    String rank = 'all',
  }) async {
    final now = date ?? DateTime.now();
    final query = <String, String>{
      'month': '${now.month}',
      'year': '${now.year}',
      'rank': rank,
    };
    final response = await _sendAuthorized(
      (headers) =>
          http.get(Uri.https(_host, '/api/habbits/', query), headers: headers),
    );
    final body = _decode(response);
    _throwIfError(response, body);

    if (body is! List) {
      throw const ApiException('Habbits response noto‘g‘ri formatda keldi');
    }

    return body
        .whereType<Map<String, dynamic>>()
        .map(ApiHabit.fromJson)
        .toList();
  }

  Future<ApiHabit> createHabit({
    required String title,
    required int duration,
    required DateTime fromDate,
    DateTime? toDate,
    required String color,
    required String icon,
  }) async {
    final payload = <String, dynamic>{
      'title': title,
      'duration': duration,
      'from_date': _date(fromDate),
      'color': color,
      'icon': icon,
    };
    if (toDate != null) {
      payload['to_date'] = _date(toDate);
    }

    final response = await _sendAuthorized(
      (headers) => http.post(
        Uri.https(_host, '/api/habbits/'),
        headers: headers,
        body: jsonEncode(payload),
      ),
    );
    final body = _decode(response);
    _throwIfError(response, body);
    if (body is! Map<String, dynamic>) {
      throw const ApiException(
        'Create habbit response noto‘g‘ri formatda keldi',
      );
    }
    return ApiHabit.fromJson(body);
  }

  Future<ApiDailyStatus> updateDailyStatus({
    required int id,
    required int status,
  }) async {
    final response = await _sendAuthorized(
      (headers) => http.patch(
        Uri.https(_host, '/api/habbit-daily-statuses/$id/'),
        headers: headers,
        body: jsonEncode({'status': status}),
      ),
    );
    final body = _decode(response);
    _throwIfError(response, body);
    if (body is! Map<String, dynamic>) {
      throw const ApiException(
        'Habbit daily status update response noto‘g‘ri formatda keldi',
      );
    }
    return ApiDailyStatus.fromJson(body);
  }

  Future<void> logout() async {
    await AuthSession.clear();
  }

  Future<http.Response> _sendAuthorized(
    Future<http.Response> Function(Map<String, String>) send,
  ) async {
    final auth = AuthSession.authorizationHeader;
    if (auth == null || auth.isEmpty) {
      throw const ApiException('Avval login qiling');
    }

    var headers = {..._jsonHeaders, 'Authorization': auth};
    var response = await _safeRequest(send(headers));

    if (response.statusCode == 401 &&
        (AuthSession.refreshToken ?? '').isNotEmpty) {
      await _refreshAccessToken();
      headers = {
        ..._jsonHeaders,
        'Authorization': AuthSession.authorizationHeader ?? '',
      };
      response = await _safeRequest(send(headers));
    }

    return response;
  }

  Future<void> _refreshAccessToken() async {
    final refresh = AuthSession.refreshToken;
    if (refresh == null || refresh.isEmpty) {
      throw const ApiException('Session tugagan. Qayta login qiling');
    }

    final response = await _safeRequest(
      http.post(
        Uri.https(_host, '/api/auth/refresh/'),
        headers: _jsonHeaders,
        body: jsonEncode({'refresh': refresh}),
      ),
    );
    final body = _decode(response);
    _throwIfError(response, body);

    if (body is! Map<String, dynamic>) {
      throw const ApiException('Refresh response noto‘g‘ri formatda keldi');
    }

    final access = body['access'] as String?;
    if (access == null || access.isEmpty) {
      throw const ApiException('Refresh token access qaytarmadi');
    }
    await AuthSession.updateAccessToken(access: access, tokenType: 'Bearer');
  }

  dynamic _decode(http.Response response) {
    if (response.body.isEmpty) return null;
    try {
      return jsonDecode(response.body);
    } catch (_) {
      return response.body;
    }
  }

  void _throwIfError(http.Response response, dynamic body) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return;
    }
    final message = _extractErrorMessage(body);
    throw ApiException(message, statusCode: response.statusCode);
  }

  String _extractErrorMessage(dynamic body) {
    if (body is Map<String, dynamic>) {
      if (body['detail'] is String) return body['detail'] as String;
      for (final value in body.values) {
        if (value is List && value.isNotEmpty) {
          return value.first.toString();
        }
        if (value is String) {
          return value;
        }
      }
      return body.toString();
    }
    if (body is String && body.isNotEmpty) return body;
    return 'Noma’lum xatolik';
  }

  Future<http.Response> _safeRequest(Future<http.Response> request) async {
    try {
      return await request;
    } on http.ClientException catch (e) {
      throw ApiException(
        'Tarmoq/CORS xatosi: ${e.message}. Backendda CORS ruxsatlarini tekshiring.',
      );
    } catch (_) {
      throw const ApiException(
        'Serverga ulanishda xatolik. Internet yoki CORS sozlamasini tekshiring.',
      );
    }
  }

  static String _date(DateTime d) {
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$y-$m-$day';
  }

  static const Map<String, String> _jsonHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}
