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

  PickedFile? _pickedImage;
  final _imagePicker = ImagePicker();
  late String _tempImagePath;
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

      print('_pickedImage: $_pickedImage'); // Debug statement

      // Assign the temporary path to a member variable
      _tempImagePath = tempPath;
    } else {
      print('No image picked'); // Debug statement
    }
  }

  Future<void> uploadImageCover() async {
    // Create Dio instance
    Dio dio = Dio();

    // Create FormData object and add the image file
    FormData formData = FormData.fromMap({
      'imageCover': await MultipartFile.fromFile(_tempImagePath,
          filename: 'converted_image.jpg'),
    });

    try {
      // final String? token = await _getToken();
      // _setAuthToken(token);
      // print('Token: $token');
      // Auth
      final String? token = await _getToken();

      // Make POST request with FormData
      Response response = await dio.patch(
        options: Options(
          headers: Map.fromEntries([
            MapEntry('Authorization', 'Bearer $token'),
          ]),
        ),
        '${ApiConstants.baseUrl}/shops/${widget.shopId}/products/${widget.productId}',
        data: formData,
      );
      // Handle the response as needed
      print('Response: ${response.data}');
    } on DioException catch (error) {
      // Handle the error
      print('Error: $error');
      print('message: ${error.message}');
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ElevatedButton(
                onPressed: () {
                  log('uploading image');
                  uploadImageCover();
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
