import 'package:dio/dio.dart';

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
}
