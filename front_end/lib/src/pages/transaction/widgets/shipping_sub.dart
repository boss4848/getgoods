import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/constants/constants.dart';

class ShippingSub extends StatelessWidget {
  const ShippingSub({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.2),
        border: Border.all(
          color: primaryColor,
          width: 2.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              top: defaultpadding,
              left: defaultpadding,
            ),
            child: Text(
              'Shipping Method',
              style: TextStyle(
                color: secondaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontFamily: 'SFTHONBURI',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(defaultpadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Standard Delivery - ส่งทำดาๆ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'SFTHONBURI',
                  ),
                ),
                Text(
                  '40' '฿',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'SFTHONBURI',
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
