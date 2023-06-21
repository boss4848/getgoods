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

import '../../constants/colors.dart';

class AddProductPage extends StatefulWidget {
  final String shopId;
  const AddProductPage({super.key, required this.shopId});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  Dio dio = Dio();

  final List<String> categories = CategoryViewModel().categories;
  int _currentIndex = -1;

  final _productName = TextEditingController();
  final _productDesc = TextEditingController();
  final _productPrice = TextEditingController();
  final _productQuantity = TextEditingController();

  // File? _pickedImage;
  // final _imagePicker = ImagePicker();
  // bool _isImageLoading = false;
  PickedFile? _pickedImage;
  final _imagePicker = ImagePicker();
  Future<void> pickImage() async {
    loadingDialog(context);
    final pickedImage = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (pickedImage != null) {
      final imageBytes = await pickedImage.readAsBytes();
      final image = img.decodeImage(imageBytes);
      final convertedImage = img.encodeJpg(
        image!,
        quality: 85,
      ); // Convert to JPEG

      setState(() {
        _pickedImage = PickedFile(pickedImage.path); // Update the picked file
      });

      // Save the converted image to a temporary file
      final tempDir = await getTemporaryDirectory();
      final tempPath = '${tempDir.path}/converted_image.jpg';
      File(tempPath).writeAsBytesSync(convertedImage);

      Navigator.pop(context);
    }
  }

  Future<void> sendRequest() async {
    String _category = '';
    if (_pickedImage == null || _currentIndex == -1) {
      return;
    }
    if (_currentIndex == 0) {
      _category = 'processed';
    } else if (_currentIndex == 1) {
      _category = 'otop';
    } else if (_currentIndex == 2) {
      _category = 'medicinalPlant';
    } else if (_currentIndex == 3) {
      _category = 'driedGood';
    }

    // FormData formData = FormData.fromMap({
    //   // 'imageCover': await MultipartFile.fromFile(
    //   //   _pickedImage!.path,
    //   //   contentType: MediaType('image', 'jpg'),
    //   // ),
    //   'name': _productName.text,
    //   'description': _productDesc.text,
    //   'price': _productPrice.text,
    //   'quantity': _productQuantity.text,
    //   'category': _category,
    //   'discount': 0,
    // });
    // log(
    //   'formData: ${formData.files}',
    // );

    try {
      final String? token = await _getToken();
      _setAuthToken(token);

      Response response = await dio.post(
        '${ApiConstants.baseUrl}/shops/${widget.shopId}/products',
        data: {
          'price': _productPrice.text,
          'quantity': _productQuantity.text,
          'category': _category,
          'description': _productDesc.text,
          'name': _productName.text,
        },
      );
      log(response.data.toString());

      print(response.data); // Handle the server response
    } on DioException catch (error) {
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
        title: const Text('Add Product'),
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
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildRichText('Image Cover', 1),
                        const SizedBox(height: 10),
                        const Text(
                          'The image cover will be used as the main product image for display in a size of 500x500 pixels.',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            if (_pickedImage != null)
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        child: Image.file(
                                          File(_pickedImage!.path),
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
                                    File(_pickedImage!.path),
                                    height: 90,
                                    width: 90,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            SizedBox(
                              width: _pickedImage == null ? 0 : 12,
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
                                  pickImage();
                                },
                                child: Text(
                                  _pickedImage == null
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
                  _buildDivider(),
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
                child: const Text('Publish Product'),
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
