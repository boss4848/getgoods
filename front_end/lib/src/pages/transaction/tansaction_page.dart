import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/constants/constants.dart';
import 'package:getgoods/src/pages/transaction/widgets/merchandise_sub.dart';
import 'package:getgoods/src/pages/transaction/widgets/my_address.dart';
import 'package:getgoods/src/pages/transaction/widgets/payment_detail.dart';
import 'package:getgoods/src/pages/transaction/widgets/shipping_sub.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Check Out',
          style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              fontFamily: 'SFTHONBURI'),
        ),
      ),
      backgroundColor: secondaryBGColor,
      body: SingleChildScrollView(
        child: Column(
          children: const [
            Padding(
              padding: EdgeInsets.only(
                  top: defaultpadding * 2,
                  left: defaultpadding * 2,
                  right: defaultpadding * 2),
              child: UserAddress(),
            ),
            MerchandiseSub(),
            SizedBox(
              height: defaultpadding * 2,
            ),
            ShippingSub(),
            SizedBox(
              height: defaultpadding * 2,
            ),
            TotalPaymentDetail()
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [defaultShadow]), // Background color of the bottom bar
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text(
                  'Total Payment',
                  style: TextStyle(
                    color: primaryTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'SFTHONBURI',
                  ),
                ),
                Text(
                  '฿ 460',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'SFTHONBURI',
                  ),
                )
              ],
            ),
            const SizedBox(
              width: defaultpadding,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(primaryColor),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // No border radius
                  ),
                ),
              ),
              onPressed: () {},
              child: const Center(
                child: Text(
                  'Place Order',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'SFTHONBURI',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
