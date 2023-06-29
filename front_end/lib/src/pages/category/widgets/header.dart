import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/pages/shopping_cart/shopping_cart.dart';

import '../../cart/cart_page.dart';

class CategoryHeader extends StatefulWidget {
  final TrackingScrollController scrollController;
  const CategoryHeader({super.key, required this.scrollController});

  @override
  State<CategoryHeader> createState() => _CategoryHeaderState();
}

class _CategoryHeaderState extends State<CategoryHeader> {
  late Color _backgroundColor;
  late Color _backgroundColorSearch;
  late Color _colorIcon;
  late double _opacity;
  late double _offset;

  final _opacityMax = 0.01;

  @override
  void initState() {
    _backgroundColor = primaryColor;
    _backgroundColorSearch = Colors.white;
    _colorIcon = Colors.white;
    _opacity = 0.0;
    _offset = 0.0;

    widget.scrollController.addListener(_onScroll);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _backgroundColor,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              _buildInputSearch(),
              const SizedBox(width: 8),
              _buildIconButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartPage(),
                    )),
                icon: CupertinoIcons.cart_fill,
                notification: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildInputSearch() {
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
