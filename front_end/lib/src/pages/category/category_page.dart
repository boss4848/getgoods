import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:getgoods/src/pages/category/widgets/catcontent.dart';
import 'package:getgoods/src/pages/category/widgets/filter.dart';
import 'package:getgoods/src/pages/category/widgets/header.dart';
import 'package:getgoods/src/viewmodels/product_viewmodel.dart';

import '../../models/product_model.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final _scrollController = TrackingScrollController();
  late ProductViewModel productViewModel;
  String category = '';

  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    productViewModel = ProductViewModel();
    // _getProducts();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _getProducts(String category) async {
    await productViewModel.filteredProduct(category);
    setState(() {
      products = productViewModel.filterProduct;
      log('In $category category has ${products.length} products');
    });
  }

  void _setCategory(String selectedCategory) {
    setState(() {
      category = selectedCategory;
    });
    print('category: $category');
    _getProducts(category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CategoryHeader(
              scrollController: _scrollController,
            ),
            ProductFilter(
              filterProduct: _setCategory,
            ),
            Column(
              children: [
                _buildHeader(category),
                CatContent(_scrollController,
                    products: products,
                    productViewModel: productViewModel,
                    onRefresh: () => _getProducts(category)),
                ElevatedButton(
                  onPressed: () {
                    _getProducts(category);
                  },
                  child: const Text('Refresh'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String headTitle) {
    String modifiedTitle = headTitle.replaceAllMapped(
      RegExp(r'([A-Z]+)(?=[A-Z][a-z])|([a-z]+)(?=[A-Z])'),
      (Match match) {
        if (match.group(1) != null) {
          return '${match.group(1)} ';
        } else {
          return '${match.group(2)} ';
        }
      },
    );

    modifiedTitle = modifiedTitle.toUpperCase();

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      child: Text(
        modifiedTitle,
        style: const TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}
