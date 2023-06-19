import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';

import '../register_shop/widgets/input_field.dart';

class StoreDetailPage extends StatelessWidget {
  const StoreDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBGColor,
      appBar: AppBar(
        title: const Text('Store Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildMerchantProfile(),
            _buildWarehouseAddress(),
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
          const Padding(
            padding: EdgeInsets.only(top: 12, left: 12, right: 12),
            child: Text(
              'Bank Account',
              style: TextStyle(
                color: primaryTextColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
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
            onSet: () {
              // print('Set Account Number');
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    //full screen height
                    height: 800,
                    // height: MediaQuery.of(context).size.height * 0.5,
                    color: Colors.white,
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Set Account Number',
                          style: TextStyle(
                            color: primaryTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'This account number will be used for receiving money from the sale of your products.',
                          style: TextStyle(
                            color: secondaryTextColor,
                            fontSize: 14,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        InputField(
                          name: 'Account Number',
                          isRequired: true,
                          controller: TextEditingController(),
                          isUnderline: true,
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text('Save'),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          _buildDivider(),
          _buildSetInput(
            label: 'Account Name',
            value: 'บริษัท จำกัด',
            onSet: () {
              print('Set Account Name');
            },
          ),
          _buildDivider(),
          _buildSetInput(
            label: 'Bank Name',
            value: 'ธนาคาร กสิกรไทย จำกัด (มหาชน)',
            onSet: () {
              print('Set Bank Name');
            },
          ),
          _buildDivider(),
          _buildSetInput(
            label: 'Branch',
            value: 'สุขาภิบาล 5',
            onSet: () {
              print('Set Branch');
            },
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Container _buildWarehouseAddress() {
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
          const Padding(
            padding: EdgeInsets.only(top: 12, left: 12, right: 12),
            child: Text(
              'Warehouse Address',
              style: TextStyle(
                color: primaryTextColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 4),
          const Padding(
            padding: EdgeInsets.only(bottom: 8, left: 12, right: 12),
            child: Text(
              '19/1 หมู่ 2 ตำบล บางพูด อำเภอ พระประแดง จังหวัด สมุทรปราการ 10130',
              style: TextStyle(
                color: grey,
                fontSize: 14,
              ),
            ),
          ),
          _buildDivider(),
          _buildSetInput(
            label: 'Province',
            value: 'Bangkok',
            onSet: () {
              print('Set Province');
            },
          ),
          _buildDivider(),
          _buildSetInput(
            label: 'District',
            value: 'Bangkok',
            onSet: () {
              print('Set District');
            },
          ),
          _buildDivider(),
          _buildSetInput(
            label: 'Sub-District',
            value: 'Bangkok',
            onSet: () {
              print('Set Sub-District');
            },
          ),
          _buildDivider(),
          _buildSetInput(
            label: 'Postal Code',
            value: '10130',
            onSet: () {
              print('Set Postal Code');
            },
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Container _buildMerchantProfile() {
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
          const Padding(
            padding: EdgeInsets.only(top: 12, left: 12, right: 12),
            child: Text(
              'Merchant Profile',
              style: TextStyle(
                color: primaryTextColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
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
            value: 'Passakorn Puttama',
            onSet: () {
              print('Set Name and Surname');
            },
          ),
          _buildDivider(),
          _buildSetInput(
            label: 'Phone Number',
            value: '0812345678',
            onSet: () {
              print('Set Phone Number');
            },
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  GestureDetector _buildSetInput({
    required String label,
    required String value,
    required Function onSet,
  }) {
    return GestureDetector(
      onTap: () => onSet(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
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
            const Text(
              'Set >',
              style: TextStyle(
                color: grey,
              ),
            ),
          ],
        ),
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
