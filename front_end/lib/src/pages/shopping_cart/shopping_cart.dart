import 'package:flutter/material.dart';
import 'package:getgoods/src/pages/shopping_cart/widgets/bottom_bar.dart';
import 'package:getgoods/src/pages/shopping_cart/widgets/cart.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Shopping Cart',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const ProductInCart(),
      bottomNavigationBar: const BottomAppBar(
        child: CustomBar(),
      ),
    );
  }
}
