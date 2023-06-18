import 'package:flutter/material.dart';
import 'package:getgoods/src/pages/login/widgets/appbar.dart';

class ShoppingCartHeader extends StatelessWidget {
  const ShoppingCartHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: (Colors.green),
      ),
      child: SafeArea(
        child: Column(
          children: const [
             TitleAppBar(
              titleName: 'Shopping Cart',
            ),
          ],
        ),
      ),
    );
  }
}
