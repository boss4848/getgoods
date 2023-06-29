import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';
import '../models/review_model.dart';

enum ReviewState {
  loading,
  success,
  error,
}

class ReviewViewModel {
  final Dio _dio = Dio();
  late List<ReviewDetail> reviews = [];
  ReviewState state = ReviewState.loading;

  Future<void> fetchReviews(String productId) async {
    final String getReviewsUrl =
        '${ApiConstants.baseUrl}/products/$productId/reviews';

    state = ReviewState.loading;
    try {
      final response = await _dio.get(getReviewsUrl);
      final data = response.data['data']['reviews'];

      reviews = List<ReviewDetail>.from(
        data.map(
          (review) {
            return ReviewDetail.fromJson(review);
          },
        ),
      );
      state = ReviewState.success;
    } catch (e) {
      print('Error fetching reviews: $e');
      state = ReviewState.error;
    }
  }

  Future<String> createReviews(
      String shopId, String productId, String review, int rating) async {
    final String createReviewsUrl =
        '${ApiConstants.baseUrl}/shops/$shopId/products/$productId/reviews';

    state = ReviewState.loading;
    print('shopId: $shopId');
    print('productId: $productId');

    try {
      final String? token = await _getToken();
      _setAuthToken(token);

      await _dio
          .post(createReviewsUrl, data: {'review': review, 'rating': rating});
      state = ReviewState.success;
      return 'success';
    } on DioException catch (e) {
      print('Error creating reviews: ${e.message}');
      print('Error response status code: ${e.response?.statusCode}');

      state = ReviewState.error;
      log(e.toString());
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
}
