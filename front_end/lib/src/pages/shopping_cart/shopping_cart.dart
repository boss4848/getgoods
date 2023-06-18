import 'package:flutter/material.dart';
import 'package:getgoods/src/pages/shopping_cart/widgets/cart.dart';
import 'package:getgoods/src/pages/shopping_cart/widgets/header.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: const [
          ShoppingCartHeader(),
          ProductInCart(),
        ],
      ),
    );
  }
}
