import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/models/user_model.dart';
import 'package:getgoods/src/pages/account_detail/widgets/update_user_address.dart';
import 'package:getgoods/src/pages/account_detail/widgets/update_user_info.dart';
import 'package:getgoods/src/viewmodels/user_viewmodel.dart';

class MyAccountDetailPage extends StatefulWidget {
  final String userId;
  const MyAccountDetailPage({super.key, required this.userId});

  @override
  State<MyAccountDetailPage> createState() => _MyAccountDetailPageState();
}

class _MyAccountDetailPageState extends State<MyAccountDetailPage> {
  final UserViewModel _userViewModel = UserViewModel();

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    await _userViewModel.fetchUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final UserDetail userDetail = _userViewModel.userDetail;

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
        title: const Text('My Account & Address'),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              color: primaryColor.withOpacity(0.5),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Icon(
                      Icons.info_rounded,
                      color: primaryColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'This information will be use for shipping address.',
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontFamily: 'SFTHONBURI'),
                    ),
                  ],
                ),
              ),
            ),
            _buildUserInfo(context, userDetail),
            _buildUserAddress(context, userDetail),
            const SizedBox(height: 200),
          ],
        ),
      ),
    );
  }

  Container _buildUserInfo(BuildContext context, UserDetail user) {
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
                    print('Edit user info');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UpdateUserInfoPage()
                          // product: _product,
                          ),
                    ).then((_) => _fetchUserDetails());
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
            value: user.name,
          ),
          _buildDivider(),
          _buildSetInput(
            label: 'Email',
            value: user.email,
          ),
          _buildDivider(),
          _buildSetInput(
            label: 'Phone Number',
            value: user.phone,
          ),
        ],
      ),
    );
  }

  Container _buildUserAddress(BuildContext context, UserDetail address) {
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
                  'Address',
                  style: TextStyle(
                    color: primaryTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    print('Edit Address');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UpdateUserAddressPage()
                          // product: _product,
                          ),
                    ).then((_) => _fetchUserDetails());
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
          // const Padding(
          //   padding: EdgeInsets.only(bottom: 8, left: 12, right: 12),
          //   child: Text(
          //     'This information will be use as shipping address.',
          //     style: TextStyle(
          //       color: grey,
          //       fontSize: 14,
          //     ),
          //   ),
          // ),
          _buildDivider(),
          _buildSetInput(label: 'Address', value: address.address.detail),
          _buildDivider(),
          _buildSetInput(
            label: 'Province',
            value: address.address.provinceEn,
          ),
          _buildDivider(),
          _buildSetInput(
            label: 'District',
            value: address.address.districtEn,
          ),
          _buildDivider(),
          _buildSetInput(
            label: 'Sub-District',
            value: address.address.subDistrictEn,
          ),
          _buildDivider(),
          _buildSetInput(
            label: 'Postal Code',
            value: address.address.postCode,
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
