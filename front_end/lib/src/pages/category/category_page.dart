import 'package:flutter/material.dart';
import 'package:getgoods/src/pages/category/widgets/filter.dart';
import 'package:getgoods/src/pages/category/widgets/product.dart';
import 'package:getgoods/src/pages/category/widgets/searchbar.dart';

import '../../models/product_model.dart';
import '../../viewmodels/product_viewmodel.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late List<Product> products;
  late ProductViewModel productViewModel;
  String category = '';

  _setCategory(String category) {
    setState(() {
      this.category = category;
    });
  }

  _filterProduct() async {
    await productViewModel.filteredProduct(category);
    setState(() {
      products = productViewModel.products;
    });
  }

  _getProduct() async {
    await productViewModel.fetchProducts();
    setState(() {
      products = productViewModel.products;
    });
  }

  @override
  void initState() {
    super.initState();
    productViewModel = ProductViewModel();
    products = productViewModel.products;
    _getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          SearchBar(),
          ProductFilter(
            filterProduct: _setCategory,
          ),
          ShowProduct(),
        ]),
      ),
    );
  }
}
