import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getgoods/src/models/cart_model.dart';

import '../../../constants/colors.dart';
import '../../../models/product_model.dart';
import '../../../utils/format.dart';

class CustomBottomBar extends StatefulWidget {
  final List<CartItem> selectedProducts;
  const CustomBottomBar({
    required this.selectedProducts,
    super.key,
  });

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int totalSelectedItems = 0;
  double totalPrice = 0;
  List<ProductCart> products = [];
  double discount = 0;
  @override
  void initState() {
    super.initState();
    totalSelectedItems = widget.selectedProducts.length;
    products = widget.selectedProducts.fold(
      [],
      (previousValue, element) => [...previousValue, ...element.products],
    );
    totalPrice = products.fold(
      0,
      (previousValue, element) => previousValue + element.price,
    );
    discount = products.fold(
      0,
      (previousValue, element) => previousValue + element.discount,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(0, -1),
            blurRadius: 10,
          ),
        ],
        // color: Colors.green,
      ),
      child: Row(
        children: [
          Container(
            height: 80,
            color: primaryBGColor,
            width: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    text: '฿ ${products.length}',
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      if (discount == 0)
                        TextSpan(
                          text: Format().currency(totalPrice, decimal: false),
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      if (discount != 0) ...[
                        TextSpan(
                          text: Format().currency(
                            totalPrice - (totalPrice * discount / 100),
                            decimal: false,
                          ),
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: Format().currency(totalPrice, decimal: false),
                          style: const TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                // Text('Total'),
                // _buildPrice(
                //   widget.selectedProducts.fold(
                //     0,
                //     (previousValue, element) =>
                //         previousValue + element.totalPrice,
                //   ),
                //   0,
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 80,
                color: primaryColor,
                child: Center(
                  child: Text(
                    'Check out ($totalSelectedItems)',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  RichText _buildPrice(
    double price,
    double discount,
  ) =>
      RichText(
        text: TextSpan(
          text: '฿ ',
          style: const TextStyle(
            color: Colors.green,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          children: [
            if (discount == 0)
              TextSpan(
                text: Format().currency(price, decimal: false),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            if (discount != 0) ...[
              TextSpan(
                text: Format().currency(
                  price - (price * discount / 100),
                  decimal: false,
                ),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const TextSpan(text: ' '),
              TextSpan(
                text: Format().currency(price, decimal: false),
                style: const TextStyle(
                  fontSize: 16,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ],
        ),
      );
}
