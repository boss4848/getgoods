import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/models/product_model.dart';
import 'package:getgoods/src/pages/product_detail/widgets/custom_bottom_bar.dart';

class CustomAppBar extends StatelessWidget {
  final ProductDetail product;
  const CustomAppBar({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    const shadow = Shadow(
      color: Color.fromARGB(255, 40, 93, 41),
      offset: Offset(0, 1),
      blurRadius: 4,
    );

    return Column(
      children: [
        SafeArea(
          child: Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            // color: Colors.black,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    CupertinoIcons.back,
                    color: Colors.white,
                    size: 32,
                    shadows: [
                      shadow,
                    ],
                  ),
                ),
                GestureDetector(
                  child: const Icon(
                    CupertinoIcons.cart_fill,
                    color: Colors.white,
                    size: 32,
                    shadows: [
                      shadow,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        CustomBottomBar(
          product: product,
        ),
      ],
    );
  }
}
