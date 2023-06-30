import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/pages/register_shop/widgets/input_field.dart';
import 'package:getgoods/src/viewmodels/shop_viewmodel.dart';
import 'package:getgoods/src/viewmodels/user_viewmodel.dart';

import '../../models/district_model.dart';
import '../../models/province_model.dart';
import '../../models/shop_model.dart';
import '../../models/sub_district_model.dart';
import '../../viewmodels/address_viewmodel.dart';

class RegisterShopPage extends StatefulWidget {
  const RegisterShopPage({super.key});

  @override
  State<RegisterShopPage> createState() => _RegisterShopPageState();
}

class _RegisterShopPageState extends State<RegisterShopPage> {
  late ShopViewModel shopViewModel = ShopViewModel();
  late UserViewModel userViewModel = UserViewModel();
  //Store Info
  final _storeNameController = TextEditingController();
  final _storeDescController = TextEditingController();

  //Bank Account
  final _bankNameController = TextEditingController();
  final _bankAccountController = TextEditingController();
  final _bankAccountNameController = TextEditingController();

  //Address
  final _locationDetailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    shopViewModel = ShopViewModel();
    addressViewModel = AddressViewModel();

    _getShopDetail();
    _getProvinces();
  }

  _getShopDetail() async {
    await shopViewModel.fetchShop(
      userViewModel.userDetail.shop.id,
    );
    log(shopViewModel.shop.name);
  }

  // int _currentIndex = 0;
  late AddressViewModel addressViewModel = AddressViewModel();

  _getProvinces() async {
    await addressViewModel.fetchProvinces();
    if (addressViewModel.provinces.isNotEmpty) {
      log(addressViewModel.provinces[0].nameTh);
    } else {
      log('No provinces loaded');
    }
  }

  bool language = true; //true = Thai, false = English
  _onSwitchLanguage() {
    setState(() {
      language = !language;
    });
  }

  _fetchDistricts(String provinceId) async {
    await addressViewModel.fetchDistricts(provinceId);
    if (addressViewModel.districts.isNotEmpty) {
      log(addressViewModel.districts[0].nameTh);
    } else {
      log('No districts loaded');
    }
  }

  _fetchSubDistricts(String districtId) async {
    await addressViewModel.fetchSubDistricts(districtId);
    if (addressViewModel.subDistricts.isNotEmpty) {
      log(addressViewModel.subDistricts[0].nameTh);
    } else {
      log('No sub-districts loaded');
    }
  }

  // String proviceNameTh = '';
  // String proviceNameEn = '';

  // String districtNameTh = '';
  late Province province = Province.empty();
  late District district = District.empty();
  late SubDistrict subDistrict = SubDistrict.empty();

  void onProvinceSelected(Province province) {
    print('Selected province: ${province.nameTh}');
    setState(() {
      this.province = province;
    });
    _fetchDistricts(province.id);
  }

  void onDistrictSelected(District district) {
    print('Selected district: ${district.nameTh}');
    setState(() {
      this.district = district;
    });
    log(district.id);
    _fetchSubDistricts(district.id);
  }

  void onSubDistrictSelected(SubDistrict subDistrict) {
    print('Selected sub-district: ${subDistrict.nameTh}');
    setState(() {
      this.subDistrict = subDistrict;
    });
  }

  void onError(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Invalid input'),
          content: Text(message),
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
  }

  onSubmit() async {
    if (_storeNameController.text == null ||
        _storeNameController.text.isEmpty ||
        _storeDescController.text == null ||
        _storeDescController.text.isEmpty) {
      onError('Please enter the store name and description');
      return;
    }

    if (_locationDetailController.text == null ||
        _locationDetailController.text.isEmpty ||
        province.id == null ||
        district.id == null ||
        subDistrict.id == null) {
      onError('Please enter the store address');
      return;
    }

    print('clicked');

    Location location = Location(
      detail: _locationDetailController.text,
      districtEn: district.nameEn,
      districtTh: district.nameTh,
      provinceEn: province.nameEn,
      provinceTh: province.nameTh,
      subDistrictEn: subDistrict.nameEn,
      subDistrictTh: subDistrict.nameTh,
      postCode: subDistrict.zipCode,
    );

    String res = await shopViewModel.createShop(
      _storeNameController.text,
      _storeDescController.text,
      location,
    );
    log('res: $res');
    if (res == 'success') {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    } else {
      //show dialog
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(res),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBGColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
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
                    'Please do finish all 3 steps to start selling!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildStep(
                    title: 'Store information',
                    inputFields: [
                      InputField(
                        name: 'Store name',
                        controller: _storeNameController,
                        isRequired: true,
                      ),
                      InputField(
                        name: 'Store description',
                        controller: _storeDescController,
                        isRequired: true,
                      ),
                    ],
                    icon: Icons.storefront_sharp,
                  ),
                  const SizedBox(height: 12),
                  _buildStep(
                    icon: Icons.store,
                    title: 'Warehouse Address',
                    switchLanguage: true,
                    onSwitchLanguage: _onSwitchLanguage,
                    language: language,
                    inputFields: [
                      InputField(
                        name: 'Location Detail',
                        controller: _locationDetailController,
                        isRequired: true,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Province *',
                            style: TextStyle(
                              fontSize: 16,
                              color: secondaryTextColor,
                            ),
                          ),
                          PopupMenuButton(
                            child: const Text(
                              'Set >',
                              style: TextStyle(
                                fontSize: 14,
                                color: grey,
                              ),
                            ),
                            onSelected: (province) {
                              onProvinceSelected(province);
                            },
                            itemBuilder: (context) {
                              return addressViewModel.provinces.map(
                                (province) {
                                  return PopupMenuItem(
                                    value: province,
                                    child: Text(language
                                        ? province.nameEn
                                        : province.nameTh),
                                  );
                                },
                              ).toList();
                            },
                          ),
                        ],
                      ),
                      Text(
                        language ? province.nameEn : province.nameTh,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'District *',
                            style: TextStyle(
                              fontSize: 16,
                              color: secondaryTextColor,
                            ),
                          ),
                          PopupMenuButton(
                            child: const Text(
                              'Set >',
                              style: TextStyle(
                                fontSize: 14,
                                color: grey,
                              ),
                            ),
                            onSelected: (district) {
                              onDistrictSelected(district);
                              // onProvinceSelected(province);
                            },
                            itemBuilder: (context) {
                              return addressViewModel.districts.map(
                                (district) {
                                  return PopupMenuItem(
                                    value: district,
                                    child: Text(
                                      language
                                          ? district.nameEn
                                          : district.nameTh,
                                    ),
                                  );
                                },
                              ).toList();
                            },
                          ),
                        ],
                      ),
                      Text(
                        language ? district.nameEn : district.nameTh,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Sub District *',
                            style: TextStyle(
                              fontSize: 16,
                              color: secondaryTextColor,
                            ),
                          ),
                          PopupMenuButton(
                            child: const Text(
                              'Set >',
                              style: TextStyle(
                                fontSize: 14,
                                color: grey,
                              ),
                            ),
                            onSelected: (subDistrict) {
                              onSubDistrictSelected(subDistrict);
                              // onProvinceSelected(province);
                            },
                            itemBuilder: (context) {
                              return addressViewModel.subDistricts.map(
                                (subDistrict) {
                                  return PopupMenuItem(
                                    value: subDistrict,
                                    child: Text(
                                      language
                                          ? subDistrict.nameEn
                                          : subDistrict.nameTh,
                                    ),
                                  );
                                },
                              ).toList();
                            },
                          ),
                        ],
                      ),
                      Text(
                        language ? subDistrict.nameEn : subDistrict.nameTh,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Postcode *',
                        style: TextStyle(
                          fontSize: 16,
                          color: secondaryTextColor,
                        ),
                      ),
                      Text(
                        subDistrict.zipCode.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildStep(
                    icon: Icons.credit_card,
                    title: 'Add Bank Account',
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
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(14),
              width: double.infinity,
              child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(primaryColor),
                ),
                onPressed: () => onSubmit(),
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 300),
          ],
        ),
      ),
    );
  }

  Container _buildStep({
    required String title,
    required List<Widget> inputFields,
    bool switchLanguage = false,
    Function? onSwitchLanguage,
    bool language = false,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: secondaryBGColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: primaryColor,
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              const SizedBox(width: 12),
              switchLanguage
                  ? GestureDetector(
                      onTap: () {
                        onSwitchLanguage!();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: primaryColor,
                        ),
                        child: Text(
                          language ? 'EN' : 'TH',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          const SizedBox(height: 12),
          ...inputFields,
        ],
      ),
    );
  }
}
