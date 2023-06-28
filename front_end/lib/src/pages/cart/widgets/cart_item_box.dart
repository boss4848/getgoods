import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../common_widgets/image_box.dart';
import '../../../common_widgets/shadow_container.dart';
import '../../../constants/colors.dart';
import '../../../models/cart_model.dart';
import '../../../utils/format.dart';
import 'quantity_box.dart';

class CartItemBox extends StatefulWidget {
  final CartItem productCart;
  final Function onSelect;
  final bool isSelected;
  const CartItemBox({
    super.key,
    required this.productCart,
    required this.onSelect,
    required this.isSelected,
  });

  @override
  State<CartItemBox> createState() => _CartItemBoxState();
}

class _CartItemBoxState extends State<CartItemBox> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      padding: false,
      items: [
        Row(
          children: [
            Checkbox(
              fillColor: MaterialStateProperty.all(primaryColor),
              value: isSelected,
              onChanged: (value) {
                // print(value);
                setState(() {
                  isSelected = value!;
                });
              },
            ),
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
        _buildDivider(),
        ...List.generate(
          widget.productCart.products.length,
          (index) => ProductCartItem(
            productCart: widget.productCart.products[index],
            onSelect: widget.onSelect,
            isSelected: isSelected,
          ),
        ),
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
  final ProductCart productCart;
  final Function onSelect;
  final bool isSelected;
  const ProductCartItem({
    super.key,
    required this.productCart,
    required this.onSelect,
    required this.isSelected,
  });

  @override
  State<ProductCartItem> createState() => _ProductCartItemState();
}

class _ProductCartItemState extends State<ProductCartItem> {
  bool? isProductCartSelected = false;

  @override
  Widget build(BuildContext context) {
    final productCart = widget.productCart;
    final onSelect = widget.onSelect;

    // bool isProductCartSelected = false;
    // onSelect(productCart);

    onCheckboxChanged(bool? value) {
      setState(() {
        isProductCartSelected = value!;
        log('isProductCartSelected: $isProductCartSelected');
      });
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 10),
        Checkbox(
          fillColor: MaterialStateProperty.all(primaryColor),
          // value: isProductCartSelected,
          // onChanged: onCheckboxChanged,
          value: isProductCartSelected,
          onChanged: (bool? value) {
            setState(() {
              isProductCartSelected = value;
            });
          },
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
                  stock: productCart.stock,
                  cartItemId: productCart.cartItemId,
                  quantity: productCart.quantity,

                  // updateQuantity: updateQuantity,
                )
              ],
            ),
          ),
        ),
      ],
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
