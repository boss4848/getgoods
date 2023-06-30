import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getgoods/src/common_widgets/error_page.dart';
import 'package:getgoods/src/common_widgets/loading.dart';
import 'package:getgoods/src/pages/my_store/widgets/order_status.dart';
import 'package:getgoods/src/pages/my_store/widgets/product_list.dart';
import 'package:getgoods/src/pages/store_analytics/store_analytics.dart';
import 'package:getgoods/src/viewmodels/address_viewmodel.dart';

import '../../constants/colors.dart';
import '../../models/district_model.dart';
import '../../models/province_model.dart';
import '../../models/sub_district_model.dart';
import '../../viewmodels/shop_viewmodel.dart';
import '../../viewmodels/user_viewmodel.dart';
import '../add_product/add_product.dart';
import '../register_shop/widgets/input_field.dart';
import '../store_detail/store_detail_page.dart';

class MyStorePage extends StatefulWidget {
  final String shopId;

  const MyStorePage({super.key, required this.shopId});

  @override
  State<MyStorePage> createState() => _MyStorePageState();
}

class _MyStorePageState extends State<MyStorePage> {
  late ShopViewModel shopViewModel = ShopViewModel();
  late UserViewModel userViewModel = UserViewModel();
  late AddressViewModel addressViewModel = AddressViewModel();

  @override
  void initState() {
    super.initState();
    shopViewModel = ShopViewModel();
    addressViewModel = AddressViewModel();
    _getShopDetail();
  }

  _getShopDetail() async {
    // print('fetching shop detail');
    await shopViewModel.fetchShop(
      widget.shopId,
    );
    setState(() {});
    // print('fetching shop detail: ${shopViewModel.shop.products.length}');
    // log(res);
    // log(shopViewModel.shopDetail.name);
  }

  @override
  Widget build(BuildContext context) {
    // ShopDetail shop = shopViewModel.shop;
    if (shopViewModel.state == ShopState.loading) {
      return const Loading();
    }
    if (shopViewModel.state == ShopState.error) {
      return const ErrorPage(pageTitle: 'My Store');
    }
    return Scaffold(
      backgroundColor: primaryBGColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => AddProductPage(
                shopId: widget.shopId,
              ),
            ),
          )
              .then(
            (_) {
              _getShopDetail();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('My Store'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderStatus(
              transactions: shopViewModel.shop.transactions,
            ),
            _buildNavigation(
              name: 'Store Detail',
              page: StoreDetailPage(
                shopId: widget.shopId,
              ),
            ),
            _buildNavigation(
              name: 'Store Analytics',
              page: StoreAnalyticsPage(
                shopId: widget.shopId,
              ),
              last: true,
            ),
            ProductList(
              products: shopViewModel.shop.products,
              shopId: widget.shopId,
              fetchData: _getShopDetail,
            ),
            const SizedBox(height: 400),
          ],
        ),
      ),
    );
  }

  _buildNavigation({
    required String name,
    required Widget page,
    bool last = false,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return page;
          },
        ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDivider(),
          Container(
            color: primaryBGColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Row(
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: grey,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
          last ? _buildDivider() : const SizedBox(),
        ],
      ),
    );
  }

  Divider _buildDivider() {
    return const Divider(
      color: grey,
      thickness: 0.5,
    );
  }
}
