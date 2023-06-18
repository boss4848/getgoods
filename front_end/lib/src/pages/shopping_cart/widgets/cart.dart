import 'package:flutter/material.dart';

class ProductInCart extends StatefulWidget {
  const ProductInCart({super.key});

  @override
  State<ProductInCart> createState() => _ProductInCartState();
}

class _ProductInCartState extends State<ProductInCart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [_product()],
        ),
      )),
    );
  }
}

_product() {
  return;
}
