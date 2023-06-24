import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:getgoods/src/common_widgets/loading_dialog.dart';
import 'package:getgoods/src/viewmodels/review_viewmodel.dart';

class ReviewForm extends StatefulWidget {
  const ReviewForm({super.key});

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
      '64874b259c858d1de5061ea0',
      '6495b956f2e406fc686299fb',
      _reviewText,
      _rating,
    );
    if (response == 'success') {
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      print(response);
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
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Write a review',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
            onChanged: (value) {
              setState(() {
                _reviewText = value;
              });
            },
          ),
          const SizedBox(height: 16.0),
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
          ElevatedButton(
            child: Text('Submit'),
            onPressed: () {
              _ReviewSubmit();
            },
          ),
        ],
      ),
    );
  }
}
