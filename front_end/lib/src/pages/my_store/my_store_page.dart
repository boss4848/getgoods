import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getgoods/src/viewmodels/address_viewmodel.dart';

import '../../constants/colors.dart';
import '../../models/district_model.dart';
import '../../models/province_model.dart';
import '../../models/shop_model.dart';
import '../../models/sub_district_model.dart';
import '../../viewmodels/shop_viewmodel.dart';
import '../../viewmodels/user_viewmodel.dart';
import '../register_shop/widgets/input_field.dart';

class MyStorePage extends StatefulWidget {
  final String shopId;

  const MyStorePage({super.key, required this.shopId});

  @override
  State<MyStorePage> createState() => _MyStorePageState();
}

class _MyStorePageState extends State<MyStorePage> {
  int _currentIndex = 0;
  late ShopViewModel shopViewModel = ShopViewModel();
  late UserViewModel userViewModel = UserViewModel();
  late AddressViewModel addressViewModel = AddressViewModel();

  @override
  void initState() {
    super.initState();
    shopViewModel = ShopViewModel();
    addressViewModel = AddressViewModel();
    _getShopDetail();
    _getProvinces();
  }

  _getShopDetail() async {
    // print('fetching shop detail');
    final res = await shopViewModel.fetchShop(
      widget.shopId,
    );
    // log(res);
    // log(shopViewModel.shopDetail.name);
  }

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

  onTap(int index) {
    setState(() {
      if (_currentIndex == index) {
        _currentIndex = -1; // close the expanded step
      } else {
        _currentIndex = index; // open the tapped step
      }
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

  Future<void> onAddAddress() async {
    if (province.id.isEmpty || district.id.isEmpty || subDistrict.id.isEmpty) {
      //show dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Please select all address fields'),
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
      return;
    }
    String res = await shopViewModel.addAddress(
      province,
      district,
      subDistrict,
      widget.shopId,
    );
    if (res != 'success') {
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
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Address added successfully'),
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
      _getShopDetail();
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
                                style: const TextStyle(
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
                            Text(
                              shopViewModel.shop.name,
                              style: const TextStyle(
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
                            Text(
                              shopViewModel.shop.description,
                              style: const TextStyle(
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
                      isSubmit: false,
                      switchLanguage: true,
                      onSwitchLanguage: _onSwitchLanguage,
                      language: language,
                      index: 1,
                      onTap: () => onTap(1),
                      onSubmit: () {
                        onAddAddress();
                      },
                      inputFields: shopViewModel.shop.location ==
                              Location.empty()
                          ? [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                language
                                    ? subDistrict.nameEn
                                    : subDistrict.nameTh,
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
                            ]
                          : [
                              const Text(
                                'Province',
                                style: TextStyle(
                                  color: secondaryTextColor,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                language
                                    ? shopViewModel.shop.location.provinceEn
                                    : shopViewModel.shop.location.provinceTh,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'District',
                                style: TextStyle(
                                  color: secondaryTextColor,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                language
                                    ? shopViewModel.shop.location.districtEn
                                    : shopViewModel.shop.location.districtTh,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'Sub District',
                                style: TextStyle(
                                  color: secondaryTextColor,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                language
                                    ? shopViewModel.shop.location.subDistrictEn
                                    : shopViewModel.shop.location.subDistrictTh,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'Postcode',
                                style: TextStyle(
                                  color: secondaryTextColor,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                shopViewModel.shop.location.postCode.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
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
    bool switchLanguage = false,
    Function? onSwitchLanguage,
    bool? language,
    bool isSubmit = true,
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
                if (switchLanguage && _currentIndex == index) ...[
                  const Spacer(),
                  const SizedBox(width: 12),
                  GestureDetector(
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
                        language! ? 'EN' : 'TH',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
            if (_currentIndex == index) ...[
              const SizedBox(height: 12),
              ...inputFields,
              const SizedBox(height: 12),
              isSubmit
                  ? SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          onSubmit();
                        },
                        child: const Text('Submit'),
                      ),
                    )
                  : const SizedBox(),
            ],
          ],
        ),
      ),
    );
  }
}
