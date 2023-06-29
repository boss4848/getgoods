import 'package:flutter/material.dart';

import 'category_page.dart';

class ShowAllProduct extends StatefulWidget {
  const ShowAllProduct({super.key});

  @override
  State<ShowAllProduct> createState() => _ShowAllProductState();
}

class _ShowAllProductState extends State<ShowAllProduct> {
  @override
  Widget build(BuildContext context) {
    return const ShowAllCatProduct(
      categoryTitle: '',
      products: [],
    );
  }
}
