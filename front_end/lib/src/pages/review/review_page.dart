import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/pages/review/widgets/review.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: primaryColor,
            title: const Text(
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'SFTHONBURI'),
                'Product Review')),
        backgroundColor: primaryBGColor,
        body: Column(
          children: [
            ReviewForm(),
          ],
        ));
  }
}
