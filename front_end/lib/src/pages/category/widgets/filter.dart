import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getgoods/src/viewmodels/product_viewmodel.dart';

import '../../../models/product_model.dart';
import '../../../utils/format.dart';
import '../../product_detail/product_detail_page.dart';

class ProductFilter extends StatefulWidget {
  const ProductFilter({super.key});

  @override
  State<ProductFilter> createState() => _ProductFilterState();
}

class _ProductFilterState extends State<ProductFilter> {
  String category = '';
  ProductViewModel productViewModel = ProductViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getFilteredProduct('');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              _buildButton(),
              Column(
                children: List.generate(
                  productViewModel.categories.length,
                  (index) => ProductItemCard(
                    productViewModel.categories[index],
                  ),
                ),
              )
            ],
          )),
    );
  }

  _buildButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 8.0), // Adjust the value as desired
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20.0), // Adjust the value as desired
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.green;
                    }
                    return Colors.grey[350]!;
                  }),
                  foregroundColor:
                      MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.white;
                    }
                    return Colors.black;
                  }),
                ),
                onPressed: () {
                  setState(() {
                    category = '';
                  });
                  _getFilteredProduct(category);
                },
                child: const Text(
                  'All',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 8.0), // Adjust the value as desired
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20.0), // Adjust the value as desired
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.green;
                    }
                    return Colors.grey[350]!;
                  }),
                  foregroundColor:
                      MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.white;
                    }
                    return Colors.black;
                  }),
                ),
                onPressed: () {
                  setState(() {
                    category = 'processed';
                  });
                  _getFilteredProduct(category);
                },
                child: const Text(
                  'Processed',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 8.0), // Adjust the value as desired
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20.0), // Adjust the value as desired
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.green;
                    }
                    return Colors.grey[350]!;
                  }),
                  foregroundColor:
                      MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.white;
                    }
                    return Colors.black;
                  }),
                ),
                onPressed: () {
                  setState(() {
                    category = 'otop';
                  });
                  _getFilteredProduct(category);
                },
                child: const Text('OTOP',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 8.0), // Adjust the value as desired
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20.0), // Adjust the value as desired
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.green;
                    }
                    return Colors.grey[350]!;
                  }),
                  foregroundColor:
                      MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.white;
                    }
                    return Colors.black;
                  }),
                ),
                onPressed: () {
                  setState(() {
                    category = 'medicinalPlant';
                  });
                  _getFilteredProduct(category);
                },
                child: const Text('Medicinal Plant',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 8.0), // Adjust the value as desired
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20.0), // Adjust the value as desired
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.green;
                    }
                    return Colors.grey[350]!;
                  }),
                  foregroundColor:
                      MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.white;
                    }
                    return Colors.black;
                  }),
                ),
                onPressed: () {
                  setState(() {
                    category = 'driedGood';
                  });
                  _getFilteredProduct(category);
                },
                child: const Text('Dried Goods',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getFilteredProduct(String category) {
    productViewModel.filterProduct(category);
  }
}

class ProductItemCard extends StatelessWidget {
  final Product product;

  const ProductItemCard(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(productId: product.id),
          ),
        );
      },
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  spreadRadius: 1,
                )
              ],
            ),
            child: Column(
              children: [
                _buildProductImage(constraints.maxHeight),
                _buildProductInfo(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductImage(double maxHeight) {
    return Stack(
      children: [
        SizedBox(
          height: maxHeight - 72,
          width: double.infinity,
          child: CachedNetworkImage(
            imageBuilder: (context, imageProvider) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                  ),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            imageUrl: product.imageCover,
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            ),
            errorWidget: (context, url, error) {
              print(url);
              print(error);
              return const Center(
                child: Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 40,
                ),
              );
            },
          ),
        ),
        if (product.discount != 0) _buildDiscount(),
      ],
    );
  }

  Positioned _buildDiscount() => Positioned(
        right: 10,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          color: const Color(0xffFAF117),
          child: Column(
            children: [
              const SizedBox(height: 3),
              Text(
                "${product.discount}%",
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
              const Text(
                "OFF",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      );

  Padding _buildProductInfo() => Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildName(),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPrice(),
                _buildSold(),
              ],
            ),
          ],
        ),
      );

  Text _buildName() => Text(
        product.name,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );

  RichText _buildPrice() => RichText(
        text: TextSpan(
          text: '฿ ',
          style: const TextStyle(
            color: Colors.green,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
              text: Format().currency(product.price, decimal: false),
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      );

  Text _buildSold() => Text(
        "${product.sold} sold",
        style: const TextStyle(
          fontSize: 10,
        ),
      );
}
