import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:getgoods/src/services/api_service.dart';
import '../../../constants/colors.dart';
import '../../../models/product_model.dart';
import '../../../utils/format.dart';
import '../../product_detail/product_detail_page.dart';

class ShowProduct extends StatefulWidget {
  const ShowProduct({Key? key}) : super(key: key);

  @override
  State<ShowProduct> createState() => _ProductLoadMoreState();
}

class _ProductLoadMoreState extends State<ShowProduct> {
  late List<Product> products;
  // late ProductViewModel productViewModel;

// productViewModel.state == ProductState.loading
//         ? Container(
//             color: Colors.white,
//             height: 600,
//             child: const Center(
//               child: CircularProgressIndicator(
//                 color: primaryColor,
//               ),
//             ),
//           )
//         :

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

  Widget _buildHeader() => Container(
        color: Colors.white,
        padding: const EdgeInsets.all(12),
        child: const Text(
          "Recommended",
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      );

  Widget _buildProductList() => Column(
        children: [
          GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.75,
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
            ),
            itemBuilder: (BuildContext context, int index) {
              return ProductItemCard(products[index]);
            },
          ),
          false ? const SizedBox(height: 150) : BottomLoader(),
        ],
      );
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
                color: primaryColor,
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
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
              const Text(
                "OFF",
                style: TextStyle(
                  color: primaryColor,
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
            color: primaryColor,
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
            color: primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
