import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';

import '../../viewmodels/shop_viewmodel.dart';

class MyAccountDetailPage extends StatefulWidget {
  final String shopId;
  const MyAccountDetailPage({super.key, required this.shopId});

  @override
  State<MyAccountDetailPage> createState() => _MyAccountDetailPageState();
}

class _MyAccountDetailPageState extends State<MyAccountDetailPage> {
  final ShopViewModel _shopViewModel = ShopViewModel();

  @override
  void initState() {
    super.initState();
    _fetchShopDetails();
  }

  Future<void> _fetchShopDetails() async {
    await _shopViewModel.fetchShop(widget.shopId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // final ShopDetail shop = _shopViewModel.shop;
    // if (_shopViewModel.state == ShopState.loading) {
    //   return const Loading();
    // }

    // if (_shopViewModel.state == ShopState.error) {
    //   return const ErrorPage(pageTitle: 'Store Detail');
    // }
    return Scaffold(
      backgroundColor: primaryBGColor,
      appBar: AppBar(
        title: const Text('My Account'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // _buildMerchantProfile(),
            // _buildWarehouseAddress(),
            _buildUsername(context),
            _buildMyaddress(context),
            const SizedBox(height: 200),
          ],
        ),
      ),
    );
  }

  Container _buildUsername(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 1.5,
            spreadRadius: 0.1,
          )
        ],
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
            child: Row(
              children: [
                const Text(
                  'User Information',
                  style: TextStyle(
                    color: primaryTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    print('Edit');
                  },
                  child: const Text(
                    'Edit',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          _buildDivider(),
          _buildSetInput(
            label: 'Username',
            value: 'test5',
          ),
          _buildDivider(),
          _buildSetInput(
            label: 'Email',
            value: 'user@gmail.com',
          ),
          _buildDivider(),
          _buildSetInput(
            label: 'Phone Number',
            value: '09487654321',
          ),
        ],
      ),
    );
  }

  Container _buildMyaddress(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 1.5,
            spreadRadius: 0.1,
          )
        ],
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
            child: Row(
              children: [
                const Text(
                  'My Address',
                  style: TextStyle(
                    color: primaryTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    print('Edit');
                  },
                  child: const Text(
                    'Edit',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          _buildDivider(),
          _buildSetInput(
            label: 'Firstname',
            value: 'Vachajo',
          ),
          _buildDivider(),
          _buildSetInput(label: 'Surname', value: 'RodRoo'),
          _buildDivider(),
          _buildSetInput(
            label: 'Phone Number',
            value: '09487654321',
          ),
          _buildDivider(),
          _buildSetInput(label: 'Address', value: 'BangNa Bansue BangYai'),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  // Container _buildWarehouseAddress() {
  //   return Container(
  //     margin: const EdgeInsets.all(12),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(10),
  //       color: Colors.white,
  //       boxShadow: const [
  //         BoxShadow(
  //           color: Colors.black26,
  //           blurRadius: 1.5,
  //           spreadRadius: 0.1,
  //         )
  //       ],
  //     ),
  //     width: double.infinity,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Padding(
  //           padding: EdgeInsets.only(top: 12, left: 12, right: 12),
  //           child: Row(
  //             children: [
  //               const Text(
  //                 'Warehouse Address',
  //                 style: TextStyle(
  //                   color: primaryTextColor,
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //               const Spacer(),
  //               GestureDetector(
  //                 onTap: () {
  //                   print('Edit');
  //                 },
  //                 child: const Text(
  //                   'Edit',
  //                   style: TextStyle(
  //                     color: primaryColor,
  //                     fontSize: 14,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         const SizedBox(height: 4),
  //         Padding(
  //           padding: const EdgeInsets.only(bottom: 8, left: 12, right: 12),
  //           child: Text(
  //             //shop.location.detail,
  //             'location',
  //             style: const TextStyle(
  //               color: grey,
  //               fontSize: 14,
  //             ),
  //           ),
  //         ),
  //         _buildDivider(),
  //         _buildSetInput(
  //           label: 'Province',
  //           value: 'shop.location.provinceEn',
  //         ),
  //         _buildDivider(),
  //         _buildSetInput(
  //           label: 'District',
  //           value: 'shop.location.districtEn',
  //         ),
  //         _buildDivider(),
  //         _buildSetInput(
  //           label: 'Sub-District',
  //           value: 'shop.location.subDistrictEn',
  //         ),
  //         _buildDivider(),
  //         _buildSetInput(
  //           label: 'Postal Code',
  //           value: 'shop.location.postCode',
  //         ),
  //         const SizedBox(height: 12),
  //       ],
  //     ),
  //   );
  // }

  // Container _buildMerchantProfile() {
  //   return Container(
  //     margin: const EdgeInsets.all(12),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(10),
  //       color: Colors.white,
  //       boxShadow: const [
  //         BoxShadow(
  //           color: Colors.black26,
  //           blurRadius: 1.5,
  //           spreadRadius: 0.1,
  //         )
  //       ],
  //     ),
  //     width: double.infinity,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.only(
  //             top: 12,
  //             left: 12,
  //             right: 12,
  //           ),
  //           child: Row(
  //             children: [
  //               const Text(
  //                 'Merchant Profile',
  //                 style: TextStyle(
  //                   color: primaryTextColor,
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //               const Spacer(),
  //               GestureDetector(
  //                 onTap: () {
  //                   print('Edit');
  //                 },
  //                 child: const Text(
  //                   'Edit',
  //                   style: TextStyle(
  //                     color: primaryColor,
  //                     fontSize: 14,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         const SizedBox(height: 4),
  //         const Padding(
  //           padding: EdgeInsets.only(bottom: 8, left: 12, right: 12),
  //           child: Text(
  //             'Verified',
  //             style: TextStyle(
  //               color: grey,
  //               fontSize: 14,
  //             ),
  //           ),
  //         ),
  //         _buildDivider(),
  //         _buildSetInput(
  //           label: 'Name and Surname',
  //           value: 'data',
  //         ),
  //         _buildDivider(),
  //         _buildSetInput(
  //           label: 'Email',
  //           value: 'data',
  //         ),
  //         _buildDivider(),
  //         _buildSetInput(
  //           label: 'Phone Number',
  //           value: '0123456789',
  //         ),
  //         const SizedBox(height: 12),
  //       ],
  //     ),
  //   );
  // }

  _buildSetInput({
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: primaryTextColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: secondaryTextColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Divider _buildDivider() {
    return const Divider(
      color: secondaryBGColor,
      thickness: 1.1,
    );
  }
}
