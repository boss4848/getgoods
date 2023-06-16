import 'package:dio/dio.dart';
import 'package:getgoods/src/constants/constants.dart';

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
}
