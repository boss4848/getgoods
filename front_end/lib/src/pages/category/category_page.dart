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
  List<String> categories = [
    'processed',
    'otop',
    'medicinalPlant',
    'driedGood'
  ];

  late ProductViewModel productViewModel;
  List<Product> products = [];
  List<Product> processedProducts = [];
  List<Product> otopProducts = [];
  List<Product> medicinalPlantProducts = [];
  List<Product> driedGoodProducts = [];

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
    await productViewModel.fetchCategory();

    setState(() {
      products = productViewModel.products;
      log('print $products');
      processedProducts =
          products.where((element) => element.category == 'processed').toList();
      if (processedProducts.length > 2) {
        processedProducts = processedProducts.sublist(0, 2);
      }
      log('pdProcessed : $processedProducts');
      otopProducts =
          products.where((element) => element.category == 'otop').toList();
      if (otopProducts.length > 2) {
        otopProducts = otopProducts.sublist(0, 2);
      }
      log('pdOtop: $otopProducts');
      medicinalPlantProducts = products
          .where((element) => element.category == 'medicinalPlant')
          .toList();
      if (medicinalPlantProducts.length > 2) {
        medicinalPlantProducts = medicinalPlantProducts.sublist(0, 2);
      }
      log('pdMedicPlant: $medicinalPlantProducts');
      driedGoodProducts =
          products.where((element) => element.category == 'driedGood').toList();
      if (driedGoodProducts.length > 2) {
        driedGoodProducts = driedGoodProducts.sublist(0, 2);
      }
      log('pdMedicPlant: $driedGoodProducts');
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
    print('category in default: $category');
    _getProducts(categories[0]);
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
                if (category.isEmpty) _defaultCategoryPage(),
                if (category.isNotEmpty) _buildHeader(category),
                if (category.isNotEmpty)
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

  Widget _defaultCategoryPage() {
    return Column(
      children: [
        _buildHeader(categories[0]),
        CatContent(_scrollController,
            onRefresh: () => _getAllProducts(),
            products: processedProducts,
            productViewModel: productViewModel),
        _buildHeader(categories[1]),
        CatContent(_scrollController,
            onRefresh: () => _getAllProducts(),
            products: otopProducts,
            productViewModel: productViewModel),
        _buildHeader(categories[2]),
        CatContent(_scrollController,
            onRefresh: () => _getAllProducts(),
            products: medicinalPlantProducts,
            productViewModel: productViewModel),
        _buildHeader(categories[3]),
        CatContent(_scrollController,
            onRefresh: () => _getAllProducts(),
            products: driedGoodProducts,
            productViewModel: productViewModel),
      ],
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
