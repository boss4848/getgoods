import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
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

  List<Product> allProcessedProducts = [];
  List<Product> allOtopProducts = [];
  List<Product> allMedicinalPlantProducts = [];
  List<Product> allDriedGoodProducts = [];

  bool showAllProducts = false;

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

      allProcessedProducts =
          products.where((element) => element.category == 'processed').toList();

      allOtopProducts =
          products.where((element) => element.category == 'otop').toList();

      allMedicinalPlantProducts = products
          .where((element) => element.category == 'medicinalPlant')
          .toList();

      allDriedGoodProducts =
          products.where((element) => element.category == 'driedGood').toList();
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
    _getProducts(category);
  }

  _setToDefault() {
    setState(() {
      category = '';
      showAllProducts = false;
    });
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
            if (category.isEmpty)
              _defaultCategoryPage()
            else if (!showAllProducts)
              Column(
                children: [
                  _buildHeader(category),
                  CatContent(
                    _scrollController,
                    products: products,
                    productViewModel: productViewModel,
                    onRefresh: () => _getProducts(category),
                  ),
                ],
              )
            else
              CatContent(
                _scrollController,
                products: products,
                productViewModel: productViewModel,
                onRefresh: () => _getProducts(category),
              ),
          ],
        ),
      ),
    );
  }

  Widget _defaultCategoryPage() {
    return Column(
      children: [
        Column(
          children: [
            Row(
              children: [
                _buildHeader(categories[0]),
                const Spacer(),
                _buildIconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowAllCatProduct(
                        categoryTitle: categories[0],
                        products: allProcessedProducts,
                      ),
                    ),
                  ),
                  icon: Icons.keyboard_arrow_right,
                  categoryTitle: categories[0],
                  categoryProducts: allProcessedProducts,
                ),
              ],
            ),
            CatContent(_scrollController,
                onRefresh: () => _getAllProducts(),
                products: processedProducts,
                productViewModel: productViewModel),
          ],
        ),
        Column(
          children: [
            Row(
              children: [
                _buildHeader(categories[1]),
                const Spacer(),
                _buildIconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowAllCatProduct(
                        categoryTitle: categories[1],
                        products: allOtopProducts,
                      ),
                    ),
                  ),
                  icon: Icons.keyboard_arrow_right,
                  categoryTitle: categories[1],
                  categoryProducts: allOtopProducts,
                ),
              ],
            ),
            CatContent(_scrollController,
                onRefresh: () => _getAllProducts(),
                products: otopProducts,
                productViewModel: productViewModel),
          ],
        ),
        Column(
          children: [
            Row(
              children: [
                _buildHeader(categories[2]),
                const Spacer(),
                _buildIconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowAllCatProduct(
                        categoryTitle: categories[2],
                        products: allMedicinalPlantProducts,
                      ),
                    ),
                  ),
                  icon: Icons.keyboard_arrow_right,
                  categoryTitle: categories[2],
                  categoryProducts: allMedicinalPlantProducts,
                ),
              ],
            ),
            CatContent(_scrollController,
                onRefresh: () => _getAllProducts(),
                products: medicinalPlantProducts,
                productViewModel: productViewModel),
          ],
        ),
        Column(
          children: [
            Row(
              children: [
                _buildHeader(categories[3]),
                const Spacer(),
                _buildIconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowAllCatProduct(
                        categoryTitle: categories[3],
                        products: allDriedGoodProducts,
                      ),
                    ),
                  ),
                  icon: Icons.keyboard_arrow_right,
                  categoryTitle: categories[3],
                  categoryProducts: allDriedGoodProducts,
                ),
              ],
            ),
            CatContent(_scrollController,
                onRefresh: () => _getAllProducts(),
                products: driedGoodProducts,
                productViewModel: productViewModel),
          ],
        ),
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
      child: Row(
        children: [
          Text(
            modifiedTitle,
            style: const TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String categoryTitle,
    required List<Product> categoryProducts,
  }) {
    return Stack(
      children: [
        IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowAllCatProduct(
                categoryTitle: categoryTitle,
                products: categoryProducts,
              ),
            ),
          ),
          icon: Icon(icon),
          iconSize: 28,
        ),
      ],
    );
  }
}

class ShowAllCatProduct extends StatefulWidget {
  final String categoryTitle;
  final List<Product> products;
  const ShowAllCatProduct(
      {Key? key, required this.categoryTitle, required this.products})
      : super(key: key);

  @override
  _ShowAllCatProductState createState() => _ShowAllCatProductState();
}

class _ShowAllCatProductState extends State<ShowAllCatProduct> {
  late ProductViewModel productViewModel;
  List<Product> products = [];
  List<Product> allProcessedProducts = [];
  List<Product> allOtopProducts = [];
  List<Product> allMedicinalPlantProducts = [];
  List<Product> allDriedGoodProducts = [];

  @override
  void initState() {
    super.initState();
    productViewModel = ProductViewModel();
    _getAllProducts();
  }

  _getAllProducts() async {
    await productViewModel.fetchCategory();

    setState(
      () {
        products = productViewModel.products;
        allProcessedProducts = products
            .where((element) => element.category == 'processed')
            .toList();
        allOtopProducts =
            products.where((element) => element.category == 'otop').toList();
        allMedicinalPlantProducts = products
            .where((element) => element.category == 'medicinalPlant')
            .toList();
        allDriedGoodProducts = products
            .where((element) => element.category == 'driedGood')
            .toList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.categoryTitle.characters.isNotEmpty
                ? '${widget.categoryTitle[0].toUpperCase()}${widget.categoryTitle.substring(1)} Products'
                : '',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
      ),
      body: Column(
        children: [
          CatContent(
            TrackingScrollController(),
            products: widget.products,
            productViewModel: productViewModel,
            onRefresh: () => _getAllProducts(),
          ),
        ],
      ),
    );
  }
}
