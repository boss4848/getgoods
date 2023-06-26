import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getgoods/src/common_widgets/image_box.dart';

import '../../../constants/colors.dart';
import '../../../models/product_model.dart';
import '../../../utils/format.dart';
import '../../transaction/tansaction_page.dart';

class CustomBottomBar extends StatefulWidget {
  final ProductDetail product;
  const CustomBottomBar({
    super.key,
    required this.product,
  });

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int selectedQuantity = 1;
  CheckoutProduct product = CheckoutProduct.empty();
  @override
  void initState() {
    super.initState();
    product = CheckoutProduct(
      id: widget.product.id,
      name: widget.product.name,
      price: widget.product.price -
          (widget.product.price * widget.product.discount / 100),
      discount: widget.product.discount,
      quantity: 1,
      imageCover: widget.product.imageCover,
    );
  }

  void updateQuantity(int value) {
    setState(() {
      selectedQuantity = value;
      product = CheckoutProduct(
        id: widget.product.id,
        name: widget.product.name,
        price: widget.product.price -
            (widget.product.price * widget.product.discount / 100),
        imageCover: widget.product.imageCover,
        quantity: selectedQuantity,
        discount: widget.product.discount,
      );
    });
    print('selectedQuantity: $selectedQuantity');
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
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  CupertinoIcons.shopping_cart,
                  color: primaryColor,
                  size: 32,
                ),
                SizedBox(width: 10),
                Text(
                  'Add to Cart',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 300,
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 120,
                                width: 120,
                                child: ImageBox(
                                  imageUrl: widget.product.imageCover,
                                  height: 120,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.product.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: primaryTextColor,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  _buildPrice(
                                    widget.product.price,
                                    widget.product.discount,
                                  ),
                                  // Text(
                                  //   '฿${widget.product.price} ฿${widget.product.price - (widget.product.price * widget.product.discount / 100)}',
                                  //   style: const TextStyle(
                                  //     fontSize: 16,
                                  //     color: primaryColor,
                                  //   ),
                                  // ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Stock: ${widget.product.quantity}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: primaryTextColor,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: primaryColor,
                                  size: 32,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 42,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Quantity',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: primaryTextColor,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                QuantityBox(
                                  quantity: widget.product.quantity,
                                  updateQuantity: updateQuantity,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CheckOutPage(
                                      shop: widget.product.shop,
                                      products: [product],
                                      subTotal:
                                          selectedQuantity * product.price,
                                    ),
                                  ),
                                );
                              },
                              child: const Text('Buy Now'),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: 80,
                color: primaryColor,
                child: const Center(
                  child: Text(
                    'Buy Now',
                    style: TextStyle(
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

class QuantityBox extends StatefulWidget {
  final int quantity;
  final Function updateQuantity;
  const QuantityBox({
    super.key,
    required this.quantity,
    required this.updateQuantity,
  });

  @override
  State<QuantityBox> createState() => _QuantityBoxState();
}

class _QuantityBoxState extends State<QuantityBox> {
  int selectedQuantity = 1;

  void increaseQuantity() {
    if (selectedQuantity < widget.quantity) {
      setState(() {
        selectedQuantity++;
      });
      widget.updateQuantity(selectedQuantity);
    }
  }

  void decreaseQuantity() {
    if (selectedQuantity > 1) {
      setState(() {
        selectedQuantity--;
      });
      widget.updateQuantity(selectedQuantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 124,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: SizedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 30,
                    height: 28,
                    child: IconButton(
                      icon: const Icon(Icons.remove),
                      iconSize: 12,
                      onPressed: decreaseQuantity,
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        left: BorderSide(color: Colors.grey),
                        right: BorderSide(color: Colors.grey),
                      ),
                    ),
                    width: 60,
                    height: 28,
                    child: Center(
                      child: Text(
                        selectedQuantity.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                    height: 28,
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      iconSize: 12,
                      onPressed: increaseQuantity,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (selectedQuantity >= widget.quantity)
            const Text(
              'Maximum Reached',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                fontSize: 10,
                color: Colors.red,
              ),
            ),
        ],
      ),
    );
  }
}
