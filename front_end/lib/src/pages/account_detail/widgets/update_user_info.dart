import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:getgoods/src/common_widgets/loading_dialog.dart';
import 'package:getgoods/src/constants/constants.dart';
import 'package:getgoods/src/models/user_model.dart';
import 'package:getgoods/src/viewmodels/user_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/colors.dart';

class UpdateUserInfoPage extends StatefulWidget {
  const UpdateUserInfoPage({
    super.key,
  });

  @override
  State<UpdateUserInfoPage> createState() => _AddUserInfoPageState();
}

class _AddUserInfoPageState extends State<UpdateUserInfoPage> {
  Dio dio = Dio();

  final _userName = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();

  final UserViewModel _userViewModel = UserViewModel();

  Future<void> sendRequest() async {
    loadingDialog(context);
    try {
      final String? token = await _getToken();
      _setAuthToken(token);

      Response response = await dio.patch(
        '${ApiConstants.baseUrl}/users/updateMe',
        data: {
          'phone': _phone.text,
          //'email': _email.text,
          'username': _userName.text,
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInputField(
                    label: 'Username',
                    hintText: 'Your new username',
                    controller: _userName,
                    totalLength: 255,
                    keyboardType: TextInputType.text,
                  ),
                  _buildDivider(),
                  // _buildInputField(
                  //   label: 'Email',
                  //   hintText: 'you cannot change',
                  //   controller: _email,
                  //   keyboardType: TextInputType.text,
                  // ),
                  _buildFixedInputField(
                    label: 'Email',
                    data: userDetail.email,
                    controller: _email,
                    keyboardType: TextInputType.text,
                  ),
                  _buildDivider(),
                  _buildInputField(
                    label: 'Phone',
                    hintText: 'Your phone number',
                    controller: _phone,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  sendRequest();
                  print(_userName);
                  print(_email);
                  print(_phone);
                },
                child: const Text('Update User'),
              ),
            ),
            const SizedBox(height: 400),
          ],
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return const Divider(
      color: secondaryBGColor,
      thickness: 1.2,
    );
  }

  Padding _buildInputField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    int totalLength = 255,
    //input type
    required TextInputType keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12,
        left: 12,
        right: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRichText(
            label,
            totalLength,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Colors.black54,
                fontSize: 16,
              ),
              //remove underline
              border: InputBorder.none,
              //remove padding
              contentPadding: EdgeInsets.zero,
            ),
            controller: controller,
          )
        ],
      ),
    );
  }

  Padding _buildFixedInputField({
    required String label,
    required String data,
    required TextEditingController controller,
    int totalLength = 255,
    //input type
    required TextInputType keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12,
        left: 12,
        right: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRichText(
            label,
            totalLength,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              data,
              style: const TextStyle(
                color: secondaryTextColor,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          )
        ],
      ),
    );
  }

  RichText _buildRichText(String label, int totalLength) {
    return RichText(
      text: TextSpan(
        text: '$label ',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        children: [
          totalLength != 0
              ? TextSpan(
                  text: '(0/$totalLength)',
                  style: const TextStyle(
                    color: secondaryTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                )
              : const TextSpan(),
          const TextSpan(
            text: '*',
            style: TextStyle(
              color: Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          )
        ],
      ),
    );
  }
}
