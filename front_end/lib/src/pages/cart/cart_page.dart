import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:getgoods/src/common_widgets/loading_dialog.dart';
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

  List<CartItem> selectedProducts = [];

  onUpdateCurrentIndex(int index) {
    setState(() {
      currentIndex = index;
    });
    for (var cartItem in cart) {
      if (currentIndex != cart.indexOf(cartItem)) {
        for (var element in cartItem.products) {
          element.isSelected = false;
          selectedProducts.remove(cartItem);
        }
        // selectedProducts.remove(cartItem);
      }
    }
    log('selectedProducts: ${selectedProducts.length}');
    log(currentIndex.toString());
  }

  removeProductFromCart(
    String shopId,
    String productId,
    String cartItemId,
    context,
  ) async {
    loadingDialog(context);
    final res = await ApiService.request(
      'DELETE',
      '${ApiConstants.baseUrl}/cart/$cartItemId',
      requiresAuth: true,
    );
    log('res: $res');
    if (res['status'] == 'success') {
      getCart();
    }
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // getCart();
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
                          removeProduct: removeProductFromCart,
                          productCart: cartitem,
                          index: cart.indexOf(cartitem),
                          currentIndex: currentIndex,
                          updateCurrentIndex: onUpdateCurrentIndex,
                          selectedProducts: selectedProducts,
                        ),
                      const SizedBox(
                        height: 200,
                      ),
                    ],
                  ),
                ),

                // const ProductInCart(),
                // const CustomBar(),
                // CustomBottomBar(
                //   selectedProducts: selectedProducts,
                // ),
              ],
            ),
    );
  }
}
