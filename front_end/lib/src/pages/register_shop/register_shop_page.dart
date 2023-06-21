import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/pages/register_shop/widgets/input_field.dart';
import 'package:getgoods/src/viewmodels/shop_viewmodel.dart';
import 'package:getgoods/src/viewmodels/user_viewmodel.dart';

class RegisterShopPage extends StatefulWidget {
  const RegisterShopPage({super.key});

  @override
  State<RegisterShopPage> createState() => _RegisterShopPageState();
}

class _RegisterShopPageState extends State<RegisterShopPage> {
  int _currentIndex = 0;
  late ShopViewModel shopViewModel = ShopViewModel();
  late UserViewModel userViewModel = UserViewModel();
  //Store Info
  final _storeNameController = TextEditingController();
  final _storeDescController = TextEditingController();

  @override
  void initState() {
    super.initState();
    shopViewModel = ShopViewModel();
    _getShopDetail();
  }

  _getShopDetail() async {
    await shopViewModel.fetchShop(
      userViewModel.userDetail.shop.id,
    );
    log(shopViewModel.shop.name);
  }

  onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  onCreateStore() async {
    final String storeName = _storeNameController.text.trim();
    final String storeDesc = _storeDescController.text.trim();

    if (storeName.isEmpty || storeDesc.isEmpty) {
      return;
    }

    final String res = await shopViewModel.createShop(
      storeName,
      storeDesc,
    );

    if (res != 'success') {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('An error occurred. $res'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      Navigator.of(context).pop();
      log('Store created successfully');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Store Registration',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: primaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Please complete the following steps to register your store',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: secondaryBGColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Create Store',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 16,
                          ),
                        ),
                        ...[
                          const SizedBox(height: 12),
                          InputField(
                            name: 'Store Name',
                            isRequired: true,
                            controller: _storeNameController,
                          ),
                          InputField(
                            name: 'Store Description',
                            isRequired: true,
                            controller: _storeDescController,
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                onCreateStore();
                              },
                              child: const Text('Submit'),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
