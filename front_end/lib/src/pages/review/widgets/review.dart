import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:getgoods/src/common_widgets/loading_dialog.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/services/api_service.dart';
import 'package:getgoods/src/viewmodels/review_viewmodel.dart';

import '../../../constants/constants.dart';

class ReviewForm extends StatefulWidget {
  final String shopId;
  final String productId;
  final String transactionId;
  const ReviewForm({
    super.key,
    required this.shopId,
    required this.productId,
    required this.transactionId,
  });

  @override
  _ReviewFormState createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  int _rating = 0;
  String _reviewText = '';

  ReviewViewModel reviewViewModel = ReviewViewModel();

  _ReviewSubmit() async {
    if (_reviewText == null || _rating == null) {
      onError('Please complete all field.');
      return;
    }
    loadingDialog(context);
    final response = await reviewViewModel.createReviews(
      //'64874b259c858d1de5061ea0',
      //'6495b956f2e406fc686299fb',
      widget.shopId,
      widget.productId,
      _reviewText,
      _rating,
    );
    final url = '${ApiConstants.baseUrl}/transactions/${widget.transactionId}';
    final res = await ApiService.request(
      'PATCH',
      url,
      data: {
        'status': 'rated',
      },
    );
    if (response == 'success') {
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      print(response);
      onError(response);
    }
  }

  void onError(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Invalid input'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [defaultShadow],
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            const Text(
              'Click the stars to rate.',
              style: TextStyle(
                color: primaryTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: 'SFTHONBURI',
              ),
            ),
            RatingBar.builder(
              initialRating: _rating.toDouble(),
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemSize: 40.0,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating.toInt();
                });
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Write a review',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              maxLines: 3,
              onChanged: (value) {
                setState(() {
                  _reviewText = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'SFTHONBURI',
                    ),
                  ),
                ),
                onPressed: () {
                  _ReviewSubmit();
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(primaryColor)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
