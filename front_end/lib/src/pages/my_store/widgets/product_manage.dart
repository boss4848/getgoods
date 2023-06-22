import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'package:getgoods/src/common_widgets/error_page.dart';
import 'package:getgoods/src/common_widgets/image_box.dart';
import 'package:getgoods/src/common_widgets/infomation_detail_box.dart';
import 'package:getgoods/src/common_widgets/loading.dart';
import 'package:getgoods/src/common_widgets/reminder_box.dart';
import 'package:getgoods/src/common_widgets/shadow_container.dart';
import 'package:getgoods/src/models/product_model.dart';
import 'package:getgoods/src/pages/update_info/update_info_page.dart';
import 'package:getgoods/src/viewmodels/product_viewmodel.dart';
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
import 'update_product.dart';

class ProductManage extends StatefulWidget {
  final String productId;
  final String shopId;
  const ProductManage(
      {super.key, required this.productId, required this.shopId});

  @override
  State<ProductManage> createState() => _ProductManagePageState();
}

class _ProductManagePageState extends State<ProductManage> {
  final ProductViewModel productViewModel = ProductViewModel();
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
    loadingDialog(context);
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  Future<void> _uploadImage(File imageFile) async {
    loadingDialog(context);
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
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      const Dialog(
        child: Text('Image uploaded successfully'),
      );
      _getProductDetail();
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      const Dialog(
        child: Text('Image upload failed'),
      );
      print('Image upload failed with status code ${response.statusCode}');
    }
  }

  Future<String?> _getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  void initState() {
    super.initState();
    _getProductDetail().then((_) {
      setState(() {
        _showBox = productViewModel.productDetail.imageCover ==
            'https://getgoods.blob.core.windows.net/product-photos/default.jpeg';
      });
    });
  }

  _getProductDetail() async {
    await productViewModel.fetchProduct(widget.productId);
    setState(() {});
  }

  late bool _showBox;

  onBoxClose() {
    setState(() {
      _showBox = false;
    });
  }

  _updateStock() async {
    final res = await productViewModel.updateStock(
      shopId: widget.shopId,
      productId: widget.productId,
      stock: _stockController.text,
      context: context,
    );
    if (res == 'success') {
      setState(() {
        _showStockInput = false;
      });
    } else {
      setState(() {
        _showStockInput = true;
      });
    }
  }

  _updateDiscount() async {
    final res = await productViewModel.updateDiscount(
      shopId: widget.shopId,
      productId: widget.productId,
      discount: _discountController.text,
      context: context,
    );
    if (res == 'success') {
      setState(() {
        _showDiscountInput = false;
      });
    } else {
      setState(() {
        _showDiscountInput = true;
      });
    }
  }

  bool _showStockInput = false;
  bool _showDiscountInput = false;

  TextEditingController _stockController = TextEditingController();
  TextEditingController _discountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (productViewModel.state == ProductState.loading) {
      return const Loading();
    }
    if (productViewModel.state == ProductState.error) {
      return const ErrorPage(pageTitle: 'Product Management');
    }

    ProductDetail _product = productViewModel.productDetail;

    Map<String, dynamic> productInfo = {
      'Product ID': _product.id,
      'Name': _product.name,
      'Description': _product.description,
      'Price': _product.price,
      'Category': _product.category,
      'Rating Average': _product.ratingsAverage,
      'Rating Quantity': _product.ratingsQuantity,
    };
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Management'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                // left: 16,
                // right: 16,
                top: 16,
                // bottom: 8,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 12),
                    _buildBox(
                      onClickBox: () {
                        setState(() {
                          _showStockInput = !_showStockInput;
                        });
                      },
                      title: 'Stock',
                      value: _product.quantity.toString(),
                    ),
                    const SizedBox(width: 12),
                    _buildBox(
                      onClickBox: () {
                        setState(() {
                          _showDiscountInput = !_showDiscountInput;
                        });
                      },
                      title: 'Discount',
                      value: '${_product.discount}%',
                    ),
                    const SizedBox(width: 12),
                    _buildBox(
                      onClickBox: () {},
                      title: 'Reviews',
                      value: '0',
                      update: false,
                    ),
                    const SizedBox(width: 12),
                    _buildBox(
                      onClickBox: () {},
                      title: 'Sold',
                      value: _product.sold.toString(),
                      color: primaryColor,
                      width: 140,
                      update: false,
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                // bottom: 8,
              ),
              child: Text(
                'Manage your merchandise by updating stock and discounts to increase sales.',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
            ),
            if (_showStockInput) ...[
              ShadowContainer(
                padding: false,
                items: [
                  _buildInputField(
                    label: 'Stock',
                    totalLength: 0,
                    hintText: 'Update your stock',
                    controller: _stockController,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[300],
                      ),
                      onPressed: () {
                        setState(() {
                          _showStockInput = false;
                        });
                      },
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () => _updateStock().then((_) {
                        _getProductDetail();
                        setState(() {});
                      }),
                      child: const Text('Update Stock'),
                    ),
                  ],
                ),
              ),
            ],
            if (_showDiscountInput) ...[
              ShadowContainer(
                padding: false,
                items: [
                  _buildInputField(
                    label: 'Discount',
                    totalLength: 0,
                    hintText: 'Update your discount percentage',
                    controller: _discountController,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[300],
                      ),
                      onPressed: () {
                        setState(() {
                          _showDiscountInput = false;
                        });
                      },
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () => _updateDiscount().then((_) {
                        _getProductDetail();
                        setState(() {});
                      }),
                      child: const Text('Update Discount'),
                    ),
                  ],
                ),
              ),
            ],
            if (_showBox)
              ReminderBox(
                title: "Don't Forget to Upload Your Image",
                message:
                    'Please ensure you upload the cover image for your product. The cover image serves as the main visual representation of your product and plays a crucial role in capturing attention. Select a high-quality and visually appealing image that effectively showcases your product. ',
                onBoxClose: onBoxClose,
              ),
            ShadowContainer(
              items: [
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
                          _imagePath == '' ? 'Upload Image' : 'Change Image',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
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
            // Container(
            //   width: double.infinity,
            //   margin: const EdgeInsets.only(
            //     top: 12,
            //     left: 12,
            //     right: 12,
            //   ),
            //   padding: const EdgeInsets.all(12),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //     color: Colors.white,
            //     boxShadow: const [
            //       BoxShadow(
            //         color: Colors.black26,
            //         blurRadius: 1.5,
            //         spreadRadius: 0.1,
            //       )
            //     ],
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       _buildRichText('Illustrative Images', 3),
            //       const SizedBox(height: 10),
            //       const Text(
            //         'These images will provide additional details about our products to increase awareness and provide more information to buyers. And display in a size of 600x600 pixels.',
            //         style: TextStyle(
            //           color: Colors.black54,
            //           fontSize: 14,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            ShadowContainer(items: [
              _buildRichText('Product Image Cover', 0),
              const SizedBox(height: 10),
              ImageBox(
                imageUrl: _product.imageCover,
                height: 400,
              )
            ]),
            InformationDetailBox(
              onEdit: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateProductPage(
                      productId: widget.productId,
                      shopId: widget.shopId,
                      // product: _product,
                    ),
                  ),
                ).then((_) {
                  _getProductDetail();
                });
              },
              title: 'Product',
              subTitle: 'Product Information',
              info: productInfo,
              updateAt: _product.updatedAt,
            ),
            const SizedBox(height: 400),
          ],
        ),
      ),
    );
  }

  GestureDetector _buildBox({
    required String title,
    required String value,
    double width = 110,
    Color color = Colors.white,
    bool update = true,
    required Function onClickBox,
  }) {
    return GestureDetector(
      onTap: () => onClickBox(),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(8),
                topRight: const Radius.circular(8),
                bottomLeft: update
                    ? const Radius.circular(0)
                    : const Radius.circular(8),
                bottomRight: update
                    ? const Radius.circular(0)
                    : const Radius.circular(8),
              ),
              color: color,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            height: 90,
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color:
                        color == Colors.white ? primaryTextColor : Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    color:
                        color == Colors.white ? primaryTextColor : Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          if (update)
            Container(
              height: 30,
              width: width,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                color: Colors.lightGreen[300],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'Update',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
        ],
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
          color: primaryTextColor,
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
