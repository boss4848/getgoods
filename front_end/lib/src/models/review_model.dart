// "review": "review 1",
// "rating": 5,
// "product": "647e11342c024208eb1d9a15",
// "user": "647aff33d480833ef51f532e",
// "createdAt": "2023-06-05T17:01:37.098Z",
// "updatedAt": "2023-06-05T17:01:37.098Z",
// "id": "647e14f1acc689ae00bdafec"

import 'user_model.dart';

class ReviewDetail {
  final String review;
  final int rating;
  final String product;
  final User user;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;

  ReviewDetail({
    required this.review,
    required this.rating,
    required this.product,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  factory ReviewDetail.fromJson(Map<String, dynamic> json) {
    return ReviewDetail(
      review: json['review'] ?? '',
      rating: json['rating'] ?? 0,
      product: json['product'] ?? '',
      user: User.fromJson(
        json['user'] ??
            {
              'photo':
                  'https://getgoods.blob.core.windows.net/user-photos/default.png',
              'name': '',
            },
      ),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      id: json['id'] ?? '',
    );
  }

  factory ReviewDetail.empty() {
    return ReviewDetail(
      review: '',
      rating: 0,
      product: '',
      user: User.empty(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      id: '',
    );
  }
}
