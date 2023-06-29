import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/constants/constants.dart';
import 'package:getgoods/src/pages/transaction/widgets/merchandise_sub.dart';
import 'package:getgoods/src/pages/transaction/widgets/my_address.dart';
import 'package:getgoods/src/pages/transaction/widgets/payment_detail.dart';
import 'package:getgoods/src/pages/transaction/widgets/shipping_sub.dart';
import 'package:getgoods/src/services/stripe_service.dart';

import '../../models/product_model.dart';
import '../../models/shop_model.dart';

class CheckOutPage extends StatefulWidget {
  final List<CheckoutProduct> products;
  final double subTotal;
  final Shop shop;

  const CheckOutPage({
    super.key,
    required this.products,
    required this.subTotal,
    required this.shop,
  });

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final double shippingFee = 40;

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
            fontFamily: 'SFTHONBURI',
          ),
        ),
      ),
      backgroundColor: secondaryBGColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: defaultpadding * 2,
                left: defaultpadding * 2,
                right: defaultpadding * 2,
              ),
              child: Container(
                decoration: BoxDecoration(boxShadow: [defaultShadow]),
                child: const UserAddress(),
              ),
            ),
            MerchandiseSub(
              products: widget.products,
              subTotal: widget.subTotal,
            ),
            const SizedBox(
              height: defaultpadding * 2,
            ),
            const ShippingSub(),
            const SizedBox(
              height: defaultpadding * 2,
            ),
            TotalPaymentDetail(
              subTotal: widget.subTotal,
              shippingFee: shippingFee,
            )
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
              children: [
                const Text(
                  'Total Payment',
                  style: TextStyle(
                    color: primaryTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'SFTHONBURI',
                  ),
                ),
                Text(
                  '฿ ${widget.subTotal + shippingFee}',
                  style: const TextStyle(
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
              onPressed: () async {
                await StripeService.stripePaymentCheckout(
                  widget.products,
                  500,
                  context,
                  mounted,
                  onSuccess: () => print('Success'),
                  onCancel: () => print('Cancel'),
                  onError: (e) => print("Error: " + e),
                );
              },
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
