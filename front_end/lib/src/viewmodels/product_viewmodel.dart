import 'dart:io';

import 'package:dio/dio.dart';
import 'package:getgoods/src/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product_model.dart';

enum ProductState {
  loading,
  success,
  error,
}

class ProductViewModel {
  final Dio _dio = Dio();
  List<Product> products = [];
  late ProductDetail productDetail = ProductDetail.empty();
  ProductState state = ProductState.loading;

  Future<void> fetchProducts() async {
    final String getProductsUrl =
        '${ApiConstants.baseUrl}/products?fields=name,price,discount,sold,imageCover';

    state = ProductState.loading;
    try {
      final response = await _dio.get(getProductsUrl);
      final data = response.data['data']['products'];
      print(data);

      products = List<Product>.from(data.map((product) {
        return Product.fromJson(product);
      }));
      state = ProductState.success;
    } catch (e) {
      print('Error fetching products: $e');
      state = ProductState.error;
    }
  }

  Future<void> fetchProduct(String productId) async {
    final String getProductUrl = '${ApiConstants.baseUrl}/products/$productId';

    state = ProductState.loading;
    try {
      final response = await _dio.get(getProductUrl);
      final data = response.data['data']['product'];

      productDetail = ProductDetail.fromJson(data);
      state = ProductState.success;
    } catch (e) {
      print('Error fetching products: $e');
      state = ProductState.error;
    }
  }

  Future<void> upLoadImage(File file) async {
    final String? token = await _getToken();
    _setAuthToken(token);

    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(file.path, filename: fileName),
    });
    try {
      _dio.patch('${ApiConstants.baseUrl}/products', data: formData);
    } on DioException catch (e) {
      print('Error uploading image: $e');
      print('message: ${e.message}');
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
