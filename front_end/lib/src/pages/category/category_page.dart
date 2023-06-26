import 'package:flutter/material.dart';
import 'package:getgoods/src/pages/category/widgets/filter.dart';
import 'package:getgoods/src/pages/category/widgets/product.dart';
import 'package:getgoods/src/pages/category/widgets/header.dart';

import '../../models/product_model.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Product> products = [];
  final _scrollControll = TrackingScrollController();
  // late ProductViewModel productViewModel;
  String category = '';

  _setCategory(String category) {
    setState(() {
      this.category = category;
    });
  }

  // _filterProduct() async {
  //   await productViewModel.filteredProduct(category);
  //   setState(() {
  //     products = productViewModel.products;
  //   });
  // }

  // _getProduct() async {
  //   await productViewModel.fetchProducts();
  //   setState(() {
  //     products = productViewModel.products;
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   productViewModel = ProductViewModel();
  //   products = productViewModel.products;
  //   _getProduct();
  // }
  @override
  void dispose() {
    _scrollControll.dispose();
    super.dispose();
    // _getProducts();
    // products = productViewModel.products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          CategoryHeader(
            scrollController: _scrollControll,
          ),
          ProductFilter(
            filterProduct: _setCategory,
          ),
          ShowProduct(),
        ]),
      ),
    );
  }
}
