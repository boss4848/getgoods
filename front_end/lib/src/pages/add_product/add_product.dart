import 'package:flutter/material.dart';
import 'package:getgoods/src/viewmodels/category_viewmodel.dart';

import '../../constants/colors.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final List<String> categories = CategoryViewModel().categories;
  int _currentIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Container(
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageUpload(),
              _buildDivider(),
              _buildInputField(
                label: 'Name',
                hintText: 'Ex. Dried Mangoes',
                controller: TextEditingController(),
                totalLength: 3,
                keyboardType: TextInputType.text,
              ),
              _buildDivider(),
              _buildInputField(
                label: 'Description',
                hintText: 'Description of your product',
                controller: TextEditingController(),
                keyboardType: TextInputType.text,
              ),
              _buildDivider(),
              _buildInputField(
                label: 'Price',
                hintText: 'Price of your product',
                controller: TextEditingController(),
                keyboardType: TextInputType.number,
              ),
              _buildDivider(),
              _buildInputField(
                label: 'Quantity',
                hintText: 'Quantity of your product',
                controller: TextEditingController(),
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
                            margin: EdgeInsets.only(right: index == 3 ? 0 : 6),
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
      ),
    );
  }

  Padding _buildImageUpload() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRichText('Image', 3),
          const SizedBox(height: 12),
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: grey,
            ),
            child: TextButton(
              onPressed: () {},
              child: TextButton(
                child: const Text(
                  textAlign: TextAlign.center,
                  'Upload Image',
                  style: TextStyle(
                    color: secondaryTextColor,
                  ),
                ),
                onPressed: () {},
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
