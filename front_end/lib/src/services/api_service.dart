import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static final Dio _dio = Dio();

  static Future<dynamic> request(
    String method,
    String url, {
    dynamic data,
    bool requiresAuth = false,
  }) async {
    try {
      if (requiresAuth) {
        final String? token = await _getToken();
        _setAuthToken(token);
      } else {
        _setAuthToken(null);
      }

      Response response;

      switch (method) {
        case 'GET':
          response = await _dio.get(url);
          break;
        case 'POST':
          response = await _dio.post(url, data: data);
          break;
        case 'PATCH':
          response = await _dio.patch(url, data: data);
          break;
        case 'DELETE':
          response = await _dio.delete(url);
          break;
        default:
          throw Exception('Invalid HTTP method: $method');
      }

      // log(response.data.toString());

      return response.data;
    } on DioException catch (e) {
      log(e.message!);
      throw Exception(
          'An error occurred while performing the $method request: ${e.message}');
    }
  }

  static Future<String?> _getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static void _setAuthToken(String? token) {
    if (token == null) {
      _dio.options.headers.remove('Authorization');
    } else {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }
}
