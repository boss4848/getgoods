import 'dart:developer';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:getgoods/src/common_widgets/loading_dialog.dart';
import 'package:getgoods/src/constants/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:getgoods/src/viewmodels/category_viewmodel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/colors.dart';

class UpdateProductPage extends StatefulWidget {
  final String shopId;
  final String productId;
  const UpdateProductPage({
    super.key,
    required this.shopId,
    required this.productId,
  });

  @override
  State<UpdateProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<UpdateProductPage> {
  Dio dio = Dio();

  final List<String> categories = CategoryViewModel().categories;
  int _currentIndex = -1;

  final _productName = TextEditingController();
  final _productDesc = TextEditingController();
  final _productPrice = TextEditingController();

  Future<void> sendRequest() async {
    loadingDialog(context);
    String _category = '';

    if (_currentIndex == 0) {
      _category = 'processed';
    } else if (_currentIndex == 1) {
      _category = 'otop';
    } else if (_currentIndex == 2) {
      _category = 'medicinalPlant';
    } else if (_currentIndex == 3) {
      _category = 'driedGood';
    }
    try {
      final String? token = await _getToken();
      _setAuthToken(token);

      Response response = await dio.patch(
        '${ApiConstants.baseUrl}/shops/${widget.shopId}/products/${widget.productId}',
        data: {
          'price': _productPrice.text,
          'category': _category,
          'description': _productDesc.text,
          'name': _productName.text,
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
      log('Error uploading image: $error');
      log('Error uploading image: ${error.response}');
      log('Error uploading image: ${error.response!.data}');
      log('Error uploading image: ${error.response!.statusCode}');
      log('Error uploading image: ${error.response!.statusMessage}');
      log('message: ${error.message}');
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
  Widget build(BuildContext context) {
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
                    label: 'Name',
                    hintText: 'Ex. Dried Mangoes',
                    controller: _productName,
                    totalLength: 255,
                    keyboardType: TextInputType.text,
                  ),
                  _buildDivider(),
                  _buildInputField(
                    label: 'Description',
                    hintText: 'Description of your product',
                    controller: _productDesc,
                    keyboardType: TextInputType.text,
                  ),
                  _buildDivider(),
                  _buildInputField(
                    label: 'Price',
                    hintText: 'Price of your product',
                    controller: _productPrice,
                    keyboardType: TextInputType.number,
                  ),
                  _buildDivider(),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildRichText('Category', 0),
                        const SizedBox(height: 12),
                        Row(
                          children: List.generate(
                            categories.length,
                            (index) => Expanded(
                              child: Container(
                                margin:
                                    EdgeInsets.only(right: index == 3 ? 0 : 6),
                                // height: 40,
                                decoration: BoxDecoration(
                                  color: _currentIndex == index
                                      ? primaryColor
                                      : Colors.white,
                                  // borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: _currentIndex == index
                                        ? Colors.transparent
                                        : primaryColor,
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _currentIndex = index;
                                    });
                                  },
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    categories[index],
                                    style: TextStyle(
                                      color: _currentIndex == index
                                          ? Colors.white
                                          : primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
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
                },
                child: const Text('Update Product'),
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
