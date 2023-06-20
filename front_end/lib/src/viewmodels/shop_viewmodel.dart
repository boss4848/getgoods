import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:getgoods/src/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/district_model.dart';
import '../models/province_model.dart';
import '../models/shop_model.dart';
import '../models/sub_district_model.dart';

enum ShopState {
  success,
  loading,
  error,
}

class ShopViewModel {
  final Dio _dio = Dio();
  ShopDetail shop = ShopDetail.empty();
  ShopState state = ShopState.loading;

  Future<String> createShop(
    String name,
    String description,
    Location location,
  ) async {
    final String createShopUrl = '${ApiConstants.baseUrl}/shops';

    state = ShopState.loading;
    print('name: $name');
    print('description: $description');
    print('location: ${location.provinceTh}');
    print('location: ${location.districtTh}');
    print('location: ${location.subDistrictTh}');
    print('location: ${location.postCode}');

    try {
      final String? token = await _getToken();
      _setAuthToken(token);

      await _dio.post(createShopUrl, data: {
        'name': name,
        'description': description,
        'location': {
          'detail': location.detail,
          'province_th': location.provinceTh,
          'district_th': location.districtTh,
          'sub_district_th': location.subDistrictTh,
          'province_en': location.provinceEn,
          'district_en': location.districtEn,
          'sub_district_en': location.subDistrictEn,
          'post_code': location.postCode,
        }
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
      // log(response.toString());
      final data = response.data['data']['data'];
      shop = ShopDetail.fromJson(data);

      state = ShopState.success;
      // log('test: ${response.data}');
      return 'success';
    } on DioException catch (e) {
      // print('Error fetching shop: ${e.message}');
      // print('Error response status code: ${e.response?.statusCode}');
      // print('Error response data: ${e.response?.data}');
      // print('Error response headers: ${e.response?.headers}');
      state = ShopState.error;
      return e.message.toString();
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

  Future<String> addAddress(
    Province province,
    District district,
    SubDistrict subDistrict,
    String shopId,
  ) async {
    state = ShopState.loading;
    try {
      final String? token = await _getToken();
      _setAuthToken(token);
      final response = await _dio.patch(
        '${ApiConstants.baseUrl}/shops/$shopId',
        data: {
          'location': {
            //th
            'province_th': province.nameTh,
            'district_th': district.nameTh,
            'subDistrict_th': subDistrict.nameTh,
            //en
            'province_en': province.nameEn,
            'district_en': district.nameEn,
            'subDistrict_en': subDistrict.nameEn,

            'postCode': subDistrict.zipCode,
          }
        },
      );
      log(response.toString());
      return 'success';
    } on DioException catch (e) {
      print('Error fetching shop: ${e.message}');
      print('Error response status code: ${e.response?.statusCode}');
      print('Error response data: ${e.response?.data}');
      print('Error response headers: ${e.response?.headers}');
      state = ShopState.error;
      return e.message.toString();
    }
  }
}
