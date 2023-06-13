import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../viewmodels/shop_viewmodel.dart';
import '../../viewmodels/user_viewmodel.dart';
import '../register_shop/widgets/input_field.dart';

class MyStorePage extends StatefulWidget {
  const MyStorePage({super.key});

  @override
  State<MyStorePage> createState() => _MyStorePageState();
}

class _MyStorePageState extends State<MyStorePage> {
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
      if (_currentIndex == index) {
        _currentIndex = -1; // close the expanded step
      } else {
        _currentIndex = index; // open the tapped step
      }
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
      log('Store created successfully');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Store'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Order Status',
                    style: TextStyle(
                      color: primaryTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: List.generate(
                      4,
                      (index) => Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          padding: const EdgeInsets.all(12),
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: primaryColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '$index',
                                style: TextStyle(
                                  color: secondaryBGColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // const SizedBox(width: 8),
                              const Text(
                                'Cancelled',
                                style: TextStyle(
                                  color: secondaryBGColor,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                onTap(0);
              },
              child: Container(
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
                      'Please do finish all 3 steps to start selling!',
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
                        color: _currentIndex == 0
                            ? secondaryBGColor
                            : Colors.green.shade700,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.check_mark_circled_solid,
                                color: _currentIndex == 0
                                    ? Colors.green
                                    : Colors.white,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Store Information',
                                style: TextStyle(
                                  color: _currentIndex == 0
                                      ? primaryColor
                                      : Colors.white,
                                  fontSize: 16,
                                  fontWeight: _currentIndex == 0
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          if (_currentIndex == 0) ...[
                            const SizedBox(height: 12),
                            const Text(
                              'Store Name',
                              style: TextStyle(
                                color: secondaryTextColor,
                                fontSize: 13,
                              ),
                            ),
                            const Text(
                              'Passakorn Online Shop',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Store Description',
                              style: TextStyle(
                                color: secondaryTextColor,
                                fontSize: 13,
                              ),
                            ),
                            const Text(
                              'This is Passakorn Shop',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildStep(
                      title: 'Warehouse Address',
                      index: 1,
                      onTap: () => onTap(1),
                      onSubmit: () {},
                      inputFields: [
                        InputField(
                          name: 'Address',
                          isRequired: true,
                          controller: TextEditingController(),
                        ),
                        InputField(
                          name: 'Location',
                          isRequired: true,
                          controller: TextEditingController(),
                        ),
                        InputField(
                          name: 'Post Code',
                          isRequired: true,
                          controller: TextEditingController(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildStep(
                      title: 'Add Bank Account',
                      index: 2,
                      onTap: () => onTap(2),
                      onSubmit: () {},
                      inputFields: [
                        InputField(
                          name: 'Account Name',
                          isRequired: true,
                          controller: TextEditingController(),
                        ),
                        InputField(
                          name: 'Account Number',
                          isRequired: true,
                          controller: TextEditingController(),
                        ),
                        InputField(
                          name: 'Bank Name',
                          isRequired: true,
                          controller: TextEditingController(),
                        ),
                        InputField(
                          name: 'Bank Branch',
                          isRequired: true,
                          controller: TextEditingController(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  GestureDetector _buildStep({
    required String title,
    required List<Widget> inputFields,
    required int index,
    required Function onSubmit,
    required Function onTap,
  }) {
    return GestureDetector(
      onTap: onTap as VoidCallback?,
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:
              _currentIndex == index ? secondaryBGColor : Colors.green.shade700,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  index == 1 ? Icons.store : Icons.account_balance,
                  color: _currentIndex == index ? Colors.green : Colors.white,
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    color: _currentIndex == index ? primaryColor : Colors.white,
                    fontSize: 16,
                    fontWeight: _currentIndex == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
            if (_currentIndex == index) ...[
              const SizedBox(height: 12),
              ...inputFields,
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    onSubmit();
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
