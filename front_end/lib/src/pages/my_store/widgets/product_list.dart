import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Products',
                style: TextStyle(
                  fontSize: 16,
                  color: primaryTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${10 + 1} products',
                style: TextStyle(
                  fontSize: 14,
                  color: secondaryTextColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildProduct(
            name: 'Product name',
            price: 1000,
            quantity: 10,
          ),
          _buildProduct(
            name: 'Product name',
            price: 1000,
            quantity: 10,
          ),
          _buildProduct(
            name: 'Product name',
            price: 1000,
            quantity: 10,
          ),
        ],
      ),
    );
  }

  Padding _buildProduct({
    required String name,
    required double price,
    required int quantity,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: CachedNetworkImage(
              imageUrl: 'https://picsum.photos/200/300',
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
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryTextColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$price',
                style: const TextStyle(
                  fontSize: 14,
                  color: secondaryTextColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Stock: $quantity',
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
    );
  }
}
