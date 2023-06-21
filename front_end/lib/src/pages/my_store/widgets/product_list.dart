import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getgoods/src/models/product_model.dart';
import 'package:getgoods/src/pages/my_store/widgets/product_manage.dart';
import 'package:getgoods/src/viewmodels/shop_viewmodel.dart';

import '../../../constants/colors.dart';

class ProductList extends StatefulWidget {
  final String shopId;
  final List<Product> products;
  const ProductList({super.key, required this.products, required this.shopId});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  ShopViewModel shopViewModel = ShopViewModel();

  @override
  Widget build(BuildContext context) {
    // print('image: ' + widget.products[0].imageCover);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Products',
                style: TextStyle(
                  fontSize: 16,
                  color: primaryTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${widget.products.length} products',
                style: const TextStyle(
                  fontSize: 14,
                  color: secondaryTextColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          for (final product in widget.products)
            _buildProduct(
              product: product,
            ),
        ],
      ),
    );
  }

  _buildProduct({
    required Product product,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ProductManage(
                productId: product.id,
                shopId: widget.shopId,
              );
            },
          ),
        );
      },
      child: Container(
        color: primaryBGColor,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: CachedNetworkImage(
                  imageUrl: product.imageCover,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  ),
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
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
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryTextColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${product.price}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: secondaryTextColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Stock: ${product.quantity}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: secondaryTextColor,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const SizedBox(
                height: 100,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: grey,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
