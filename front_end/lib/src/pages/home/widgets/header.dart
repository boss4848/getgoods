import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getgoods/src/common_widgets/shadow_container.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/constants/constants.dart';
import 'package:getgoods/src/pages/shopping_cart/shopping_cart.dart';
import 'package:getgoods/src/services/api_service.dart';

import '../../../models/cart_model.dart';
import '../../../models/product_model.dart';
import '../../cart/cart_page.dart';
import '../../product_detail/product_detail_page.dart';

class Header extends StatefulWidget {
  final TrackingScrollController scrollController;
  final int totalCartItems;
  // final List<CartItem> cart;
  final Function getCart;
  const Header({
    super.key,
    required this.scrollController,
    required this.totalCartItems,
    // required this.cart,
    required this.getCart,
  });

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  late Color _backgroundColor;
  late Color _backgroundColorSearch;
  late Color _colorIcon;
  late double _opacity;
  late double _offset;

  final _opacityMax = 0.01;

  List<String> searchProducts = [];
  List<String> productId = [];
  // List<String> searchProductsName = [];

  onSearch(String value) async {
    print(value);

    final String url = '${ApiConstants.baseUrl}/products/search/$value';
    final res = await ApiService.request('GET', url);

    setState(() {
      // Map into a list and cast to String
      searchProducts = res['data']['products']
          .map((e) => e['name'].toString())
          .cast<String>()
          .toList();

      productId = res['data']['products']
          .map((e) => e['id'].toString())
          .cast<String>()
          .toList();

      print(searchProducts);
    });
  }

  @override
  void initState() {
    _backgroundColor = Colors.transparent;
    _backgroundColorSearch = Colors.white;
    _colorIcon = Colors.white;
    _opacity = 0.0;
    _offset = 0.0;

    widget.scrollController.addListener(_onScroll);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: _backgroundColor,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  _buildInputSearch(onSearch),
                  const SizedBox(width: 8),
                  _buildIconButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(
                            // cart: widget.cart,
                            // getCart: widget.getCart,
                            // totalCartItems: widget.totalCartItems,
                            ),
                      ),
                    ).then((_) => widget.getCart()),
                    icon: CupertinoIcons.cart_fill,
                    notification: widget.totalCartItems,
                  ),
                  // _buildIconButton(
                  //   onPressed: () => print('click'),
                  //   icon: Icons.chat,
                  //   notification: 1,
                  // ),
                ],
              ),
            ),
          ),
        ),
        // Container(
        //   width: double.infinity,
        //   margin: const EdgeInsets.symmetric(horizontal: 12),
        //   padding: const EdgeInsets.all(12),
        //   color: Colors.white,
        //   child: const Text('data'),
        // ),
        ...List.generate(
          searchProducts.length,
          (index) => GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(
                  productId: productId[index],
                ),
              ),
            ),
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.all(12),
              color: Colors.white,
              child: Text(searchProducts[index]),
            ),
          ),
        ),
      ],
    );
  }

  _buildInputSearch(Function onSearch) {
    const sizeIcon = BoxConstraints(
      minWidth: 40,
      minHeight: 40,
    );
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.transparent,
        width: 0,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(6),
      ),
    );
    return Expanded(
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 0.2,
            blurRadius: 7,
            offset: const Offset(0, 1),
          )
        ]),
        child: TextField(
          onChanged: (value) => onSearch(value),
          style: const TextStyle(
            fontSize: 18,
            color: Colors.green,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(4),
            isDense: true,
            enabledBorder: border,
            focusedBorder: border,
            hintText: "Getgoods",
            hintStyle: const TextStyle(
              fontSize: 18,
              color: Colors.green,
            ),
            prefixIcon: const Icon(
              CupertinoIcons.search,
              color: Colors.green,
            ),
            prefixIconConstraints: sizeIcon,
            filled: true,
            fillColor: _backgroundColorSearch,
          ),
        ),
      ),
    );
  }

  _buildIconButton({
    required VoidCallback onPressed,
    required IconData icon,
    int notification = 0,
  }) {
    return Stack(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(icon),
          color: _colorIcon,
          iconSize: 28,
        ),
        notification <= 0
            ? const SizedBox()
            : Positioned(
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.green,
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 22,
                    minHeight: 22,
                  ),
                  child: Text(
                    '$notification',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  void _onScroll() {
    final scrollOffset = widget.scrollController.offset;
    //scroll up
    if (scrollOffset >= _offset && scrollOffset > 5) {
      _opacity = double.parse((_opacity + _opacityMax).toStringAsFixed(2));
      if (_opacity >= 1.0) {
        _opacity = 1.0;
      }
    }
    //scroll down
    else if (scrollOffset < 100) {
      _opacity = double.parse((_opacity - _opacityMax).toStringAsFixed(2));
      if (_opacity <= 1.0) {
        _opacity = 0.0;
      }
    }
    setState(() {
      if (scrollOffset <= 0) {
        _backgroundColorSearch = Colors.white;
        _colorIcon = Colors.white;
        _opacity = 0.0;
        _offset = 0.0;
      } else {
        _backgroundColorSearch = Colors.grey.shade200;
        _colorIcon = Colors.deepOrange;
      }
      _backgroundColor = Colors.white.withOpacity(_opacity);
    });
  }
}
