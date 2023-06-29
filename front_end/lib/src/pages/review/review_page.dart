import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/pages/review/widgets/review.dart';

class ReviewPage extends StatelessWidget {
  final String shopId;
  final String productId;
  final String productName;
  final String transactionId;
  const ReviewPage({
    super.key,
    required this.shopId,
    required this.productId,
    required this.productName,
    required this.transactionId,
  });

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
            'Product Review',
          ),
        ),
        backgroundColor: primaryBGColor,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Container(
                decoration: const BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productName,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'SFTHONBURI'),
                          ),
                          Text(
                            'Product ID : $productId',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'SFTHONBURI'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            ReviewForm(
              transactionId: transactionId,
              shopId: shopId,
              productId: productId,
            ),
          ],
        ));
  }
}
