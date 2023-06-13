import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:getgoods/src/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/shop_model.dart';

enum ShopState {
  success,
  loading,
  error,
}

class ShopViewModel {
  final Dio _dio = Dio();
  ShopDetail shop = ShopDetail.empty();
  ShopState state = ShopState.loading;

  Future<String> createShop(String name, String description) async {
    final String createShopUrl = '${ApiConstants.baseUrl}/shops';

    state = ShopState.loading;
    print('name: $name');
    print('description: $description');
    try {
      final String? token = await _getToken();
      _setAuthToken(token);

      await _dio.post(createShopUrl, data: {
        'name': name,
        'description': description,
      });
      // final data = response.data['data']['shop'];

      // log(response.toString());
      // log('success');
      // shops = Shop.fromJson(data);
      state = ShopState.success;
      return 'success';
    } on DioException catch (e) {
      print('Error creating shop: ${e.message}');
      print('Error response status code: ${e.response?.statusCode}');
      print('Error response data: ${e.response?.data}');
      print('Error response headers: ${e.response?.headers}');

      state = ShopState.error;
      log(e.toString());
      return e.message.toString();
    }
  }

  fetchShop(String shopId) async {
    final String fetchShopUrl = '${ApiConstants.baseUrl}/shops/$shopId';
    state = ShopState.loading;

    try {
      final response = await _dio.get(fetchShopUrl);

      final data = response.data['data']['shop'];
      shop = ShopDetail.fromJson(data);

      state = ShopState.success;
      return 'success';
    } on DioException catch (e) {
      // print('Error fetching shop: ${e.message}');
      // print('Error response status code: ${e.response?.statusCode}');
      // print('Error response data: ${e.response?.data}');
      // print('Error response headers: ${e.response?.headers}');
      state = ShopState.error;
      return e;
    }
  }

  Future<String?> _getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  void _setAuthToken(String? token) {
    if (token == null) {
      throw Exception('No token found');
    }
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }
}
