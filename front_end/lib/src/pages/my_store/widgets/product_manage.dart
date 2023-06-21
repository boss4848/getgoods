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
import 'package:http/http.dart' as http;
import '../../../constants/colors.dart';

class ProductManage extends StatefulWidget {
  final String productId;
  final String shopId;
  const ProductManage(
      {super.key, required this.productId, required this.shopId});

  @override
  State<ProductManage> createState() => _ProductManagePageState();
}

class _ProductManagePageState extends State<ProductManage> {
  Dio dio = Dio();

  final List<String> categories = CategoryViewModel().categories;
  int _currentIndex = -1;

  final _productName = TextEditingController();
  final _productDesc = TextEditingController();
  final _productPrice = TextEditingController();
  final _productQuantity = TextEditingController();

  //Sending image to server
  String _imagePath = '';

  Future<void> _getImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  Future<void> _uploadImage(File imageFile) async {
    final String? token = await _getToken();
    var request = http.MultipartRequest(
      'PATCH',
      Uri.parse(
        '${ApiConstants.baseUrl}/shops/${widget.shopId}/products/${widget.productId}',
      ),
    );
    request.headers['Authorization'] = 'Bearer $token';

    request.files.add(await http.MultipartFile.fromPath(
      'imageCover',
      imageFile.path,
      contentType: MediaType('image', 'jpeg'),
    ));

    var response = await request.send();
    log(response.statusCode.toString());
    // log(response.data.toString());
    log(response.request.toString());
    log(response.stream.toString());

    if (response.statusCode == 200) {
      print('Image uploaded successfully');
    } else {
      print('Image upload failed with status code ${response.statusCode}');
    }
  }

  Future<String?> _getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Management'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(
                top: 12,
                left: 12,
                right: 12,
                bottom: 4,
              ),
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
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRichText('Image Cover', 1),
                    const SizedBox(height: 10),
                    const Text(
                      'The image cover will be used as the main product image for display in a size of 600x600 pixels.',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        if (_imagePath != '')
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    child: Image.file(
                                      File(_imagePath),
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 1.5,
                                    spreadRadius: 0.1,
                                  )
                                ],
                              ),
                              child: Image.file(
                                File(_imagePath),
                                height: 90,
                                width: 90,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        SizedBox(
                          width: _imagePath == '' ? 0 : 12,
                        ),
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: grey,
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: grey,
                            ),
                            onPressed: () {
                              _getImageFromGallery();
                            },
                            child: Text(
                              _imagePath == ''
                                  ? 'Upload Image'
                                  : 'Change Image',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ElevatedButton(
                onPressed: () {
                  log('uploading image');
                  _uploadImage(
                    File(_imagePath),
                  );
                },
                child: const Text('Update Image'),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(
                top: 12,
                left: 12,
                right: 12,
              ),
              padding: const EdgeInsets.all(12),
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
                  _buildRichText('Illustrative Images', 3),
                  const SizedBox(height: 10),
                  const Text(
                    'These images will provide additional details about our products to increase awareness and provide more information to buyers. And display in a size of 600x600 pixels.',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(
                top: 12,
                left: 12,
                right: 12,
              ),
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
                  _buildInputField(
                    label: 'Quantity',
                    hintText: 'Quantity of your product',
                    controller: _productQuantity,
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   margin: const EdgeInsets.only(top: 12),
            //   padding: const EdgeInsets.symmetric(horizontal: 12),
            //   width: double.infinity,
            //   height: 50,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       sendRequest();
            //     },
            //     child: const Text('Publish Product'),
            //   ),
            // ),
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
