import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getgoods/src/common_widgets/image_box.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/constants/constants.dart';

import '../../../models/product_model.dart';

class MerchandiseSub extends StatelessWidget {
  final List<CheckoutProduct> products;
  final double subTotal;
  const MerchandiseSub({
    super.key,
    required this.products,
    required this.subTotal,
  });

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
            padding: const EdgeInsets.all(defaultpadding),
            child: Row(
              children: const [
                Icon(
                  Icons.storefront_rounded,
                  color: primaryColor,
                  size: 30,
                ),
                Text(
                  ' Store Name',
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
          CheckOutProductList(
            products: products,
            subTotal: subTotal,
          ),
        ],
      ),
    );
  }
}

class CheckOutProductList extends StatefulWidget {
  final double subTotal;
  final List<CheckoutProduct> products;
  const CheckOutProductList({
    super.key,
    required this.products,
    required this.subTotal,
  });

  @override
  State<CheckOutProductList> createState() => _CheckOutProductListState();
}

class _CheckOutProductListState extends State<CheckOutProductList> {
  int totalAmount = 0;
  double totalPrice = 0;

  void updateTotal(int amount, double price) {
    setState(() {
      totalAmount += amount;
      totalPrice += price;
    });
  }

  int items = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ...widget.products.map(
            (product) {
              items += product.quantity;
              return _buildMercProduct(
                name: product.name,
                amount: product.quantity,
                price: product.price,
                image: product.imageCover,
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MerchandiseSubtotal(
              totalAmount: items,
              totalPrice: widget.subTotal,
            ),
          ),
        ],
      ),
    );
  }
}

Container _buildMercProduct({
  required String image,
  required String name,
  required int amount,
  required double price,
}) {
  return Container(
    decoration: BoxDecoration(color: Colors.grey[200]),
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: ImageBox(
                imageUrl: image,
                height: 60,
              ),
            ),
            const SizedBox(
              width: defaultpadding / 2,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: primaryTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'SFTHONBURI',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$price฿',
                  style: const TextStyle(
                    color: primaryTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'SFTHONBURI',
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(width: 5),
        Text(
          'x$amount',
          style: const TextStyle(
            color: primaryTextColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'SFTHONBURI',
          ),
        )
      ],
    ),
  );
}

class MerchandiseSubtotal extends StatelessWidget {
  final int totalAmount;
  final double totalPrice;

  const MerchandiseSubtotal({
    Key? key,
    required this.totalAmount,
    required this.totalPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Text(
              'Merchandise Subtotal',
              style: TextStyle(
                color: primaryTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: 'SFTHONBURI',
              ),
            ),
            Text(' ($totalAmount items)',
                style: const TextStyle(
                  color: primaryTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'SFTHONBURI',
                )),
          ],
        ),
        Text(
          '$totalPrice ฿',
          style: const TextStyle(
            color: primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            fontFamily: 'SFTHONBURI',
          ),
        )
      ],
    );
  }
}
