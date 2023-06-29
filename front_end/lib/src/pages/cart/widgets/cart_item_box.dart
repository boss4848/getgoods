import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:getgoods/src/models/product_model.dart';
import 'package:getgoods/src/pages/transaction/tansaction_page.dart';
import 'package:timeago/timeago.dart';

import '../../../common_widgets/image_box.dart';
import '../../../common_widgets/shadow_container.dart';
import '../../../constants/colors.dart';
import '../../../models/cart_model.dart';
import '../../../utils/format.dart';
import 'quantity_box.dart';

class CartItemBox extends StatefulWidget {
  final int index;
  final CartItem productCart;
  final int currentIndex;
  final Function updateCurrentIndex;
  final List<CartItem> selectedProducts;
  final Function removeProduct;

  const CartItemBox({
    Key? key,
    required this.index,
    required this.productCart,
    required this.currentIndex,
    required this.updateCurrentIndex,
    required this.selectedProducts,
    required this.removeProduct,
  }) : super(key: key);

  @override
  State<CartItemBox> createState() => _CartItemBoxState();
}

class _CartItemBoxState extends State<CartItemBox> {
  double totalPrice = 0.0;
  double totalDiscount = 0.0;
  double subTotal = 0.0;
  List<CheckoutProduct> checkoutProducts = [];

  void fetchData() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      padding: false,
      items: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              const Icon(
                Icons.storefront_outlined,
                color: primaryTextColor,
              ),
              const SizedBox(width: 10),
              Text(
                widget.productCart.shopName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryTextColor,
                ),
              ),
            ],
          ),
        ),
        _buildDivider(),
        ...List.generate(
          widget.productCart.products.length,
          (index) {
            return ProductCartItem(
              removeProduct: widget.removeProduct,
              fetchData: fetchData,
              productCart: widget.productCart.products[index],
              value: widget.productCart.products[index].isSelected,
              onChange: (value) {
                setState(() {
                  // if (widget.currentIndex != widget.index) {
                  widget.productCart.products[index].isSelected = value;
                  log('widget.productCart.products[index].isSelected: ${widget.productCart.products[index].isSelected}');

                  // }
                  if (widget.productCart.products[index].isSelected == true) {
                    widget.selectedProducts.add(widget.productCart);
                    // totalPrice += widget.productCart.products[index].price;
                    totalPrice += (widget.productCart.products[index].price *
                        widget.productCart.products[index].quantity);
                    // totalDiscount += (widget.productCart.products[index].price *
                    //     ((100 - widget.productCart.products[index].discount) /
                    //         100) *
                    //     widget.productCart.products[index].quantity);
                    totalDiscount += (widget.productCart.products[index].price *
                        (widget.productCart.products[index].discount / 100) *
                        widget.productCart.products[index].quantity);
                    subTotal = (totalPrice - totalDiscount);

                    checkoutProducts.add(
                      CheckoutProduct(
                        id: widget.productCart.products[index].productId,
                        name: widget.productCart.products[index].name,
                        price: widget.productCart.products[index].price -
                            (widget.productCart.products[index].price *
                                (widget.productCart.products[index].discount /
                                    100)),
                        discount: widget.productCart.products[index].discount,
                        quantity: widget.productCart.products[index].quantity,
                        imageCover:
                            widget.productCart.products[index].imageCover,
                        shopName: widget.productCart.shopName,
                        shopId: widget.productCart.products[index].shop.id,
                      ),
                    );

                    // subTotal += (totalPrice - totalDiscount) *
                    //     widget.productCart.products[index].quantity;
                    // totalDiscount +=
                    //     (widget.productCart.products[index].discount) *
                    //         widget.productCart.products[index].quantity;
                    // totalPrice += (widget.productCart.products[index].price *
                    //     widget.productCart.products[index].quantity);
                    // log(widget.productCart.products[index].quantity.toString());
                  } else {
                    widget.selectedProducts.remove(widget.productCart);
                    totalPrice -= (widget.productCart.products[index].price *
                        widget.productCart.products[index].quantity);
                    // totalDiscount -= widget.productCart.products[index].price *
                    //     ((100 - widget.productCart.products[index].discount) /
                    //         100) *
                    //     widget.productCart.products[index].quantity;
                    totalDiscount -= (widget.productCart.products[index].price *
                        (widget.productCart.products[index].discount / 100) *
                        widget.productCart.products[index].quantity);
                    subTotal = (totalPrice - totalDiscount);
                    // totalPrice -= widget.productCart.products[index].price;
                    // totalDiscount -=
                    //     widget.productCart.products[index].discount;
                    checkoutProducts.removeWhere(
                      (element) =>
                          element.id ==
                          widget.productCart.products[index].productId,
                    );
                    // subTotal -= (totalPrice - totalDiscount) *
                    //     widget.productCart.products[index].quantity;
                    // totalDiscount -=
                    //     (widget.productCart.products[index].discount) *
                    //         widget.productCart.products[index].quantity;
                    // totalPrice -= (widget.productCart.products[index].price) *
                    //     widget.productCart.products[index].quantity;
                  }
                  widget.updateCurrentIndex(widget.index);
                });
              },
            );
          },
        ),
        if (widget.selectedProducts.isNotEmpty &&
            widget.currentIndex == widget.index) ...[
          _buildDivider(),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  top: 12,
                  bottom: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryTextColor,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '฿ ${totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Padding(
                padding: const EdgeInsets.only(
                  right: 12,
                  top: 12,
                  bottom: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Saved',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryTextColor,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '฿ ${totalDiscount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckOutPage(
                        products: checkoutProducts,
                        shop: widget.productCart.products[0].shop,
                        subTotal: subTotal,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(
                        8,
                      ),
                    ),
                    color: primaryColor,
                  ),
                  width: 200,
                  height: 67,
                  child: Center(
                    child: Text(
                      'Check out (${widget.selectedProducts.length})',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
        // ...List.generate(widget.selectedProducts.length, (index) {
        //   return Column(
        //     children: [
        //       _buildDivider(),
        //       Container(
        //         height: 30,
        //         color: primaryBGColor,
        //       ),
        //     ],
        //   );
        // }
        // (index) => Text(
        //   widget.selectedProducts[index].products[index].name,
        // ),
        // ),
      ],
    );
  }

  Divider _buildDivider() {
    return const Divider(
      height: 0,
      color: secondaryBGColor,
      thickness: 1.2,
    );
  }
}

class ProductCartItem extends StatefulWidget {
  final Function(bool) onChange;
  final ProductCart productCart;
  final bool value;
  final Function fetchData;
  final Function removeProduct;

  const ProductCartItem({
    Key? key,
    required this.productCart,
    required this.onChange,
    required this.value,
    required this.fetchData,
    required this.removeProduct,
  }) : super(key: key);

  @override
  State<ProductCartItem> createState() => _ProductCartItemState();
}

class _ProductCartItemState extends State<ProductCartItem> {
  @override
  Widget build(BuildContext context) {
    final productCart = widget.productCart;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 10),
        Checkbox(
          fillColor: MaterialStateProperty.all(primaryColor),
          value: widget.value,
          onChanged: (bool? value) => widget.onChange(value!),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: SizedBox(
            height: 100,
            width: 100,
            child: ImageBox(
              imageUrl: productCart.imageCover,
              height: 100,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 12,
              right: 12,
              bottom: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      productCart.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryTextColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => widget.removeProduct(
                        productCart.shop.id,
                        productCart.productId,
                        productCart.cartItemId,
                        context,
                      ),
                      child: const Icon(
                        Icons.delete,
                        color: grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  productCart.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: primaryTextColor,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                _buildPrice(
                  productCart.price,
                  productCart.discount,
                ),
                const SizedBox(height: 10),
                Text(
                  'Stock: ${productCart.stock}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: primaryTextColor,
                  ),
                ),
                const SizedBox(height: 10),
                QuantityBox(
                  fetchData: widget.fetchData,
                  stock: productCart.stock,
                  cartItemId: productCart.cartItemId,
                  quantity: productCart.quantity,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  RichText _buildPrice(double price, double discount) {
    return RichText(
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
}
