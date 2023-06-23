import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';

import '../../common_widgets/error_page.dart';
import '../../common_widgets/loading.dart';
import '../../models/shop_model.dart';
import '../../viewmodels/shop_viewmodel.dart';
import '../register_shop/widgets/input_field.dart';

class StoreDetailPage extends StatefulWidget {
  final String shopId;
  const StoreDetailPage({super.key, required this.shopId});

  @override
  State<StoreDetailPage> createState() => _StoreDetailPageState();
}

class _StoreDetailPageState extends State<StoreDetailPage> {
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
    final ShopDetail shop = _shopViewModel.shop;
    if (_shopViewModel.state == ShopState.loading) {
      return const Loading();
    }

    if (_shopViewModel.state == ShopState.error) {
      return const ErrorPage(pageTitle: 'Store Detail');
    }
    return Scaffold(
      backgroundColor: primaryBGColor,
      appBar: AppBar(
        title: const Text('Store Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildMerchantProfile(shop),
            _buildWarehouseAddress(shop),
            _buildBankAccount(context),
            const SizedBox(height: 200),
          ],
        ),
      ),
    );
  }

  Container _buildBankAccount(BuildContext context) {
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
                  'Bank Account',
                  style: TextStyle(
                    color: primaryTextColor,
                    fontSize: 16,
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
          const Padding(
            padding: EdgeInsets.only(bottom: 8, left: 12, right: 12),
            child: Text(
              'ธนาคาร กสิกรไทย จำกัด (มหาชน) สาขา สุขาภิบาล 5 ชื่อบัญชี บริษัท จำกัด',
              style: TextStyle(
                color: grey,
                fontSize: 14,
              ),
            ),
          ),
          _buildDivider(),
          _buildSetInput(
            label: 'Account Number',
            value: '1234567890',
          ),
          _buildDivider(),
          _buildSetInput(
            label: 'Account Name',
            value: 'บริษัท จำกัด',
          ),
          _buildDivider(),
          _buildSetInput(
            label: 'Bank Name',
            value: 'ธนาคาร กสิกรไทย จำกัด (มหาชน)',
          ),
          _buildDivider(),
          _buildSetInput(
            label: 'Branch',
            value: 'สุขาภิบาล 5',
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Container _buildWarehouseAddress(ShopDetail shop) {
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
            padding: EdgeInsets.only(top: 12, left: 12, right: 12),
            child: Row(
              children: [
                const Text(
                  'Warehouse Address',
                  style: TextStyle(
                    color: primaryTextColor,
                    fontSize: 16,
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
          Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 12, right: 12),
            child: Text(
              shop.location.detail,
              style: const TextStyle(
                color: grey,
                fontSize: 14,
              ),
            ),
          ),
          _buildDivider(),
          _buildSetInput(
            label: 'Province',
            value: shop.location.provinceEn,
          ),
          _buildDivider(),
          _buildSetInput(
            label: 'District',
            value: shop.location.districtEn,
          ),
          _buildDivider(),
          _buildSetInput(
            label: 'Sub-District',
            value: shop.location.subDistrictEn,
          ),
          _buildDivider(),
          _buildSetInput(
            label: 'Postal Code',
            value: shop.location.postCode,
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Container _buildMerchantProfile(ShopDetail shop) {
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
            padding: const EdgeInsets.only(
              top: 12,
              left: 12,
              right: 12,
            ),
            child: Row(
              children: [
                const Text(
                  'Merchant Profile',
                  style: TextStyle(
                    color: primaryTextColor,
                    fontSize: 16,
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
          const Padding(
            padding: EdgeInsets.only(bottom: 8, left: 12, right: 12),
            child: Text(
              'Verified',
              style: TextStyle(
                color: grey,
                fontSize: 14,
              ),
            ),
          ),
          _buildDivider(),
          _buildSetInput(
            label: 'Name and Surname',
            value: shop.owner.name,
          ),
          _buildDivider(),
          _buildSetInput(
            label: 'Email',
            value: shop.owner.email,
          ),
          _buildDivider(),
          _buildSetInput(
            label: 'Phone Number',
            value: shop.owner.phoneNumber == ''
                ? 'Not Set'
                : shop.owner.phoneNumber,
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

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
