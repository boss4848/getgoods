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

  String category = '';

  late ProductViewModel productViewModel;
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    productViewModel = ProductViewModel();
    _getAllProducts();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _getAllProducts() async {
    await productViewModel.fetchProducts();

    setState(() {
      products = productViewModel.products;
    });
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

  _setToDefault() {
    setState(() {
      category = '';
    });
    print('category: You set to default');
    _getAllProducts();
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
              defaultProduct: _setToDefault,
            ),
            Column(
              children: [
                if (category.isEmpty) _buildHeader('Recommended'),
                // CatContent(_scrollController,
                //     onRefresh: () => _getAllProducts(),
                //     products: products,
                //     productViewModel: productViewModel),
                if (category.isNotEmpty) _buildHeader(category),
                CatContent(
                  _scrollController,
                  products: products,
                  productViewModel: productViewModel,
                  onRefresh: () => _getProducts(category),
                ),
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

    modifiedTitle = modifiedTitle.toLowerCase();

    if (modifiedTitle.isNotEmpty) {
      modifiedTitle =
          modifiedTitle[0].toUpperCase() + modifiedTitle.substring(1);
    }
    return Container(
      color: Colors.white,
      alignment: Alignment.centerLeft,
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
