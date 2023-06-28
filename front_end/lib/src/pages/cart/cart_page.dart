import 'dart:developer';

import 'package:flutter/material.dart';
// import 'package:getgoods/src/common_widgets/image_box.dart';
// import 'package:getgoods/src/common_widgets/shadow_container.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/pages/cart/widgets/cart_item_box.dart';
// import 'package:getgoods/src/pages/shopping_cart/widgets/bottom_bar.dart';
import '../../constants/constants.dart';
import '../../models/cart_model.dart';
import '../../services/api_service.dart';
// import '../../utils/format.dart';
import 'widgets/custom_bottom_bar.dart';
// import 'widgets/quantity_box.dart';

class CartPage extends StatefulWidget {
  // final List<CartItem> cart;
  // final int totalCartItems;
  // final Function getCart;
  const CartPage({
    super.key,
    // required this.cart,
    // required this.totalCartItems,
    // required this.getCart,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartItem> cart = [];
  List<ProductCart> selectedProductCart = [];

  @override
  void initState() {
    super.initState();
    getCart();
  }

  getCart() async {
    final res = await ApiService.request('GET', '${ApiConstants.baseUrl}/cart');

    final Map<String, dynamic> data = res['data'];
    final List<dynamic> cartData = data['cart'];
    cart = cartData.map((e) => CartItem.fromJson(e)).toList();
    log('cart: ${cart[0].shopName}');

    setState(() {});
  }

  void updateSelectedProductCart(ProductCart productCart) {
    setState(() {
      if (selectedProductCart.contains(productCart)) {
        selectedProductCart.clear();
      } else {
        selectedProductCart = [productCart];
      }
      log('selectedProductCart 1: $selectedProductCart');
    });
  }

  void onSelectCartItem(ProductCart cartItem) {
    setState(() {
      if (selectedProductCart.contains(cartItem)) {
        selectedProductCart.remove(cartItem);
      } else {
        selectedProductCart.add(cartItem);
      }
      log('selectedProductCart 2: $selectedProductCart');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBGColor,
      appBar: AppBar(
        title: const Text(
          'Shopping Cart',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: cart.isEmpty
          ? const Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(
                    // fontSize: 25,
                    // fontWeight: FontWeight.bold,
                    ),
              ),
            )
          : Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var cartitem in cart)
                        CartItemBox(
                          productCart: cartitem,
                          onSelect: onSelectCartItem,
                          isSelected: selectedProductCart.contains(cartitem),
                        ),
                      const SizedBox(
                        height: 200,
                      ),
                    ],
                  ),
                ),

                // const ProductInCart(),
                // const CustomBar(),
                const CustomBottomBar(),
              ],
            ),
    );
  }
}
