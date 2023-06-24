import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/constants/constants.dart';

class TotalPaymentDetail extends StatelessWidget {
  const TotalPaymentDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [defaultShadow],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: defaultpadding, left: defaultpadding),
            child: Row(
              children: const [
                Icon(
                  Icons.receipt_rounded,
                  color: primaryColor,
                  size: 30,
                ),
                Text(
                  ' Payment Details',
                  style: TextStyle(
                    color: primaryTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'SFTHONBURI',
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(defaultpadding),
            child: Column(
              children: [
                _buildSubtotalDetail(name: 'Merchandise Subtotal', amount: 12),
                const SizedBox(
                  height: defaultpadding / 2,
                ),
                _buildSubtotalDetail(name: 'Shipping Subtotal', amount: 40),
                const SizedBox(
                  height: defaultpadding / 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Total Payment',
                      style: TextStyle(
                        color: primaryTextColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'SFTHONBURI',
                      ),
                    ),
                    Text(
                      '12฿', //sum of amount
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'SFTHONBURI',
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

Row _buildSubtotalDetail({
  required String name,
  required double amount,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        name,
        style: const TextStyle(
          color: primaryTextColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: 'SFTHONBURI',
        ),
      ),
      Text(
        '$amount฿',
        style: const TextStyle(
          color: primaryTextColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: 'SFTHONBURI',
        ),
      )
    ],
  );
}
