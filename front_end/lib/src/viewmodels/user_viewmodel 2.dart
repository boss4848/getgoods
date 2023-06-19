import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constants.dart';
import '../models/user_model.dart';

enum UserState {
  idle,
  loading,
  success,
  error,
}

class UserViewModel {
  final Dio _dio = Dio();
  List<User> users = [];
  UserDetail userDetail = UserDetail.empty();
  UserState state = UserState.idle;

  Future<void> fetchUser() async {
    try {
      updateState(UserState.idle);
      final String? token = await _getToken();
      _setAuthToken(token);
      updateState(UserState.loading);
      final response = await _dio.get('${ApiConstants.baseUrl}/users/me');
      log(response.toString());
      userDetail = UserDetail.fromJson(response.data['data']['user']);
      updateState(UserState.success);
    } on DioException catch (e) {
      log(e.message!);
      print('Error fetching user: $e');
      updateState(UserState.error);
    }
  }

  Future<String> login(String email, String password) async {
    try {
      updateState(UserState.loading);
      final response = await _dio.post('${ApiConstants.baseUrl}/users/login',
          data: {'email': email, 'password': password});
      await _storeToken(response.data['token']);
      updateState(UserState.success);
      return 'success';
    } on DioException catch (e) {
      print('Error logging in: $e');
      updateState(UserState.error);
      return _handleDioError(e);
    }
  }

  Future<void> logout() async {
    await _removeToken();
    userDetail = UserDetail.empty();
    updateState(UserState.idle);
  }

  Future<String?> _getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> _storeToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> _removeToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  void _setAuthToken(String? token) {
    if (token == null) {
      throw Exception('No token found');
    }
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void updateState(UserState newState) {
    state = newState;
  }

  String _handleDioError(DioException e) {
    switch (e.response?.statusCode) {
      case 400:
        return 'Bad Request';
      case 401:
        return 'Invalid email or password';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not Found';
      case 500:
        return 'Internal Server Error';
      default:
        return 'Unknown error occurred';
    }
  }
}
