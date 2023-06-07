import 'package:flutter/material.dart';
import '../../../models/product_model.dart';
import '../../../utils/format.dart';
import '../../../viewmodels/product_viewmodel.dart';

class ProductLoadMore extends StatelessWidget {
  final List<ProductModel> _productViewModel = ProductViewModel().getProduct();

  ProductLoadMore({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(),
          _buildProductList(),
        ],
      ),
    );
  }

  _buildHeader() => Container(
        color: Colors.white,
        padding: const EdgeInsets.all(12),
        child: const Text(
          "Recommeded",
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      );

  Column _buildProductList() => Column(
        children: [
          GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _productViewModel.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.75,
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              // mainAxisSpacing: 6,
              // crossAxisSpacing: 6,
            ),
            itemBuilder: (BuildContext context, int index) {
              return ProductItemCard(_productViewModel[index]);
            },
          ),
          false ? const SizedBox(height: 150) : BottomLoader(),
        ],
      );
}

class ProductItemCard extends StatelessWidget {
  final ProductModel product;

  const ProductItemCard(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
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
    );
  }

  Stack _buildProductImage(double maxHeight) {
    return Stack(
      children: [
        Container(
          height: maxHeight - 82,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14),
            ),
            image: DecorationImage(
              image: NetworkImage(product.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Image.network(
        //   product.image,
        //   height: maxHeight - 82,
        //   width: double.infinity,
        //   fit: BoxFit.cover,
        // ),
        if (product.discountPercentage != 0) _buildDiscount(),
        // if (product.shopRecommended) _buildShopRecommended(),
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
                "${product.discountPercentage}%",
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
          children: [
            _buildName(),
            const SizedBox(height: 12),
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

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12, bottom: 22),
      width: double.infinity,
      alignment: Alignment.center,
      child: const Center(
        child: Text(
          "Loading...",
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
