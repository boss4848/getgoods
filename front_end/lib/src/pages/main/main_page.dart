import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import '../../constants/constants.dart';
import '../../models/cart_model.dart';
import '../../services/api_service.dart';
import '../Messages/messages_page.dart';
import '../category/category_page.dart';
import '../../models/menu_model.dart';
import '../../viewmodels/menu_viewmodel.dart';
import '../home/home_page.dart';
import '../profile/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MainPage> {
  final List<MenuModel> _menuViewModel = MenuViewModel().getMenus();
  int _selectedIndex = 0;

  List<CartItem> cart = [CartItem.empty()];
  int totalCartItems = 0;

  Future<void> getCart() async {
    final getCartUrl = '${ApiConstants.baseUrl}/cart';
    final res = await ApiService.request(
      'GET',
      getCartUrl,
      requiresAuth: true,
    );

    final Map<String, dynamic> data = res['data'];
    log('data: $data');
    log("totalItems: ${data['totalItems']}");
    totalCartItems = data['totalItems'];
    setState(() {});

    // final List<dynamic> cartData = data['cart'];
    // cart = cartData.map((e) => CartItem.fromJson(e)).toList();
    // log('cart: ${cart[0].shopName}');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _menuViewModel.length,
      child: Scaffold(
        // backgroundColor: Colors.green,
        backgroundColor: secondaryBGColor,
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            HomePage(
              MediaQuery.of(context).size,
              MediaQuery.of(context).padding.bottom,
            ),
            const CategoryPage(),
            const MessagesPage(),
            ProfilePage(
              getCart: getCart,
              totalCartItems: totalCartItems,
            ),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: grey.withOpacity(0.2),
            ),
            //boxShadow: [
            // BoxShadow(
            //   color: Colors.black26,
            //   blurRadius: 1.5,
            //   spreadRadius: 0.5,
            // )
            //],
            color: Colors.white,
          ),
          child: SafeArea(
              child: CustomTabBar(
            menuViewModel: _menuViewModel,
            selectedIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          )),
        ),
      ),
    );
  }
}

class CustomTabBar extends StatelessWidget {
  final List<MenuModel> menuViewModel;
  final int selectedIndex;
  final Function(int) onTap;

  const CustomTabBar({
    super.key,
    required this.menuViewModel,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorColor: Colors.transparent,
      indicatorPadding: EdgeInsets.zero,
      labelPadding: EdgeInsets.zero,
      tabs: menuViewModel
          .asMap()
          .map(
            (int index, MenuModel menuModel) {
              final isSelect = index == selectedIndex;

              final color = isSelect ? primaryColor : Colors.black54;

              String text = menuModel.label;

              // if (!isSelect && index == 0) {
              //   text = "หน้าแรก";
              // }

              return MapEntry(
                index,
                Tab(
                  iconMargin: const EdgeInsets.all(0),
                  icon: const SizedBox(),
                  child: Column(
                    children: [
                      _buildIcon(
                        icon:
                            isSelect ? menuModel.iconSelected : menuModel.icon,
                        color: color,
                        index: index,
                      ),
                      _buildLabel(
                        text: text,
                        color: color,
                        wrapText: menuViewModel[0].label == text,
                      ),
                    ],
                  ),
                ),
              );
            },
          )
          .values
          .toList(),
      onTap: onTap,
    );
  }

  _buildIcon(
          {required IconData icon, required Color color, required int index}) =>
      Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(
            icon,
            color: color,
            size: 30,
          ),
          if (index == 2)
            Positioned(
              right: -6,
              top: -6,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white),
                ),
                constraints: const BoxConstraints(
                  minWidth: 12,
                  minHeight: 12,
                ),
                child: const Text(
                  '199',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      );
  _buildLabel(
          {required String text,
          required Color color,
          required bool wrapText}) =>
      Baseline(
        baselineType: TextBaseline.alphabetic,
        baseline: 12,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 9,
            color: color,
            letterSpacing: wrapText ? -1.0 : null,
          ),
        ),
      );
}
