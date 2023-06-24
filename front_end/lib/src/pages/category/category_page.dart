import 'package:flutter/material.dart';
import 'package:getgoods/src/pages/category/widgets/filter.dart';
import 'package:getgoods/src/pages/category/widgets/product.dart';
import 'package:getgoods/src/pages/category/widgets/searchbar.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: const [
          SearchBar(),
          ProductFilter(),
          ShowProduct(),
        ]),
      ),
    );
  }
}
