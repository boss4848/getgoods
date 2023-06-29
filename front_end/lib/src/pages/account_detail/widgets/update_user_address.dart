import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:getgoods/src/common_widgets/loading_dialog.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/constants/constants.dart';
import 'package:getgoods/src/models/district_model.dart';
import 'package:getgoods/src/models/province_model.dart';
import 'package:getgoods/src/models/sub_district_model.dart';
import 'package:getgoods/src/pages/register_shop/widgets/input_field.dart';
import 'package:getgoods/src/viewmodels/address_viewmodel.dart';
import 'package:getgoods/src/viewmodels/user_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateUserAddressPage extends StatefulWidget {
  const UpdateUserAddressPage({super.key});

  @override
  State<UpdateUserAddressPage> createState() => _UpdateUserAddressPageState();
}

class _UpdateUserAddressPageState extends State<UpdateUserAddressPage> {
  late UserViewModel userViewModel = UserViewModel();

  Dio dio = Dio();

  //Address
  final _locationDetailController = TextEditingController();

  @override
  void initState() {
    super.initState();

    addressViewModel = AddressViewModel();

    _getProvinces();
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

  Future<void> sendRequest() async {
    loadingDialog(context);
    try {
      final String? token = await _getToken();
      _setAuthToken(token);

      // print(_phone.text);
      print(_locationDetailController.text);
      print(district.nameEn);
      print(district.nameTh);

      Response response = await dio.patch(
        '${ApiConstants.baseUrl}/users/updateMe',
        data: {
          'address': {
            'detail': _locationDetailController.text,
            'district_en': district.nameEn,
            'district_th': district.nameTh,
            'province_en': province.nameEn,
            'province_th': province.nameTh,
            'sub_district_en': subDistrict.nameEn,
            'sub_district_th': subDistrict.nameTh,
            'post_code': subDistrict.zipCode,
          }

          //'email': _email.text,
        },
      );
      log(response.data.toString());

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);

      print(response.data); // Handle the server response
    } on DioException catch (error) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(error.response!.data['message']),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'))
          ],
        ),
      );
    }
  }

  Future<String?> _getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  void _setAuthToken(String? token) {
    if (token == null) {
      throw Exception('No token found');
    }
    dio.options.headers['Authorization'] = 'Bearer $token';
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

  // onSubmit() async {
  //   // if (_storeNameController.text == null ||
  //   //     _storeNameController.text.isEmpty ||
  //   //     _storeDescController.text == null ||
  //   //     _storeDescController.text.isEmpty) {
  //   //   onError('Please enter the store name and description');
  //   //   return;
  //   // }

  //   if (_locationDetailController.text == null ||
  //       _locationDetailController.text.isEmpty ||
  //       province.id == null ||
  //       district.id == null ||
  //       subDistrict.id == null) {
  //     onError('Please enter the store address');
  //     return;
  //   }

  //   print('clicked');

  //   Location address = Location(
  //     detail: _locationDetailController.text,
  //     districtEn: district.nameEn,
  //     districtTh: district.nameTh,
  //     provinceEn: province.nameEn,
  //     provinceTh: province.nameTh,
  //     subDistrictEn: subDistrict.nameEn,
  //     subDistrictTh: subDistrict.nameTh,
  //     postCode: subDistrict.zipCode,
  //   );

  //   String res = await shopViewModel.createShop(
  //       // _storeNameController.text,
  //       // _storeDescController.text,
  //       location as String);
  //   log('res: $res');
  //   if (res == 'success') {
  //     // ignore: use_build_context_synchronously
  //     Navigator.of(context).pop();
  //   } else {
  //     //show dialog
  //     // ignore: use_build_context_synchronously
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: const Text('Error'),
  //           content: Text(res),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: const Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBGColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: const Text(
          'Update Address',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: primaryColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildStep(
                        icon: Icons.location_on_rounded,
                        title: 'Address',
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
                      Container(
                        padding: const EdgeInsets.all(14),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => sendRequest(),
                          child: const Text(
                            'UPDATE ADDRESS',
                            style: TextStyle(color: primaryColor),
                          ),
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.white)),
                        ),
                      ),
                    ],
                  ),
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
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Colors.green,
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
