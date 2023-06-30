import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/models/product_model.dart';
import 'package:getgoods/src/pages/Messages/widgets/chat_room.dart';
import 'package:getgoods/src/viewmodels/chat_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common_widgets/custom_app_bar.dart';
import '../../constants/constants.dart';
import '../../models/review_model.dart';
import '../../services/api_service.dart';
import '../../utils/format.dart';
import '../../viewmodels/product_viewmodel.dart';
import '../../viewmodels/review_viewmodel.dart';

class ProductDetailPage extends StatefulWidget {
  final String? productId;
  const ProductDetailPage({super.key, this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late ProductDetail product;
  late ProductViewModel productViewModel;
  late List<ReviewDetail> reviews;
  late ReviewViewModel reviewViewModel;
  late ChatViewModel chatViewModel;

  Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    productViewModel = ProductViewModel();
    product = productViewModel.productDetail;

    reviewViewModel = ReviewViewModel();
    reviews = reviewViewModel.reviews;

    _getProduct();
    _getReview();
  }

  _getProduct() async {
    await productViewModel.fetchProduct(widget.productId!);
    setState(() {
      product = productViewModel.productDetail;
      log('product: ${product.name}');
      log('ownerId: ${product.shop.ownerId}');
    });
  }

  _getReview() async {
    await reviewViewModel.fetchReviews(widget.productId!);
    setState(() {
      reviews = reviewViewModel.reviews;
      log('reviews: ${reviews.length}');
      // log('product: ${product.name}');
    });
  }

  Future<void> createChat() async {
    final response = await ApiService.request(
      'POST',
      '${ApiConstants.baseUrl}/chats/createChat',
      requiresAuth: true,
      data: {'ownerId': product.shop.ownerId},
    );

    log(response);
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
      // appBar: AppBar(
      //   title: const Text("Product detail"),
      // ),
      body: productViewModel.state == ProductState.loading
          ? Container(
              color: Colors.white,
              height: 600,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              ),
            )
          : Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 400,
                        width: double.infinity,
                        child: CachedNetworkImage(
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
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                // textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: primaryTextColor,
                                ),
                              ),
                              const SizedBox(height: 6),
                              _buildPrice(),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Stars(
                                    rate: product.ratingsAverage.toInt(),
                                    size: 22,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    product.ratingsAverage.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: secondaryTextColor,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Text(
                                    '|',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: secondaryTextColor,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${product.sold} sold',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: secondaryTextColor,
                                    ),
                                  ),
                                  const Spacer(),
                                  // const Icon(
                                  //   CupertinoIcons.heart_solid,
                                  //   color: pastelRed,
                                  //   size: 26,
                                  // )
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.shop.name,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: primaryTextColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(
                                        'Active 1 hour ago',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF9B9B9B),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            CupertinoIcons.location,
                                            color: Color(0xFF9B9B9B),
                                            size: 16,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${product.shop.location.provinceEn}, ${product.shop.location.districtEn}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF9B9B9B),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      createChat();
                                    },
                                    //outlined
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 10),
                                      backgroundColor: Colors.transparent,
                                      foregroundColor: primaryColor,
                                      side: const BorderSide(
                                        color: primaryColor,
                                        width: 2,
                                      ),
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),

                                    child: Row(
                                      children: const [
                                        // Icon(
                                        //   CupertinoIcons.bubble_right,
                                        //   color: primaryColor,
                                        // ),
                                        // SizedBox(width: 7),
                                        Text(
                                          'Chat Now',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                product.description,
                                style: const TextStyle(
                                  fontSize: 16,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'Reviews',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: primaryTextColor,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Column(
                                children: [
                                  for (var review in reviews)
                                    ReviewItem(
                                      review: review,
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 300),
                      // Container(
                      //   color: Colors.red,
                      //   height: 1000,
                      // ),
                    ],
                  ),
                ),
                CustomAppBar(
                  product: product,
                ),

                // const CustomBottomBar(),

                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //   child: AppBar(

                //     actions: [
                //       IconButton(
                //         onPressed: () {},
                //         icon: const Icon(
                //           Icons.shopping_cart,
                //           size: 30,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Container(
                //   color: Colors.green,
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.stretch,
                //     children: [
                //       // _buildHeader(),
                //       // _buildProductList(),
                //     ],
                //   ),
                // ),
              ],
            ),
    );
  }

  RichText _buildPrice() => RichText(
        text: TextSpan(
          text: '฿ ',
          style: const TextStyle(
            color: Colors.green,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          children: [
            if (product.discount == 0)
              TextSpan(
                text: Format().currency(product.price, decimal: false),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            if (product.discount != 0) ...[
              TextSpan(
                text: Format().currency(
                  product.price - (product.price * product.discount / 100),
                  decimal: false,
                ),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const TextSpan(text: ' '),
              TextSpan(
                text: Format().currency(product.price, decimal: false),
                style: TextStyle(
                  color: Colors.black.withOpacity(0.3),
                  fontSize: 16,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ],
        ),
      );
}

class ReviewItem extends StatelessWidget {
  final ReviewDetail review;
  const ReviewItem({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.grey[300],
          child: CachedNetworkImage(
            imageBuilder: (context, imageProvider) {
              return CircleAvatar(
                radius: 28,
                backgroundImage: imageProvider,
              );
            },
            imageUrl: review.user.photo,
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
                  size: 25,
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              review.user.name,
              style: const TextStyle(
                fontSize: 18,
                color: primaryTextColor,
              ),
            ),
            Stars(
              rate: review.rating.toInt(),
              size: 18,
            ),
            // const SizedBox(height: 4),
            // Row(
            //   children: const [
            //     Text(
            //       'Product: ',
            //       style: TextStyle(
            //         fontSize: 13,
            //         color: secondaryTextColor,
            //       ),
            //     ),
            //     SizedBox(width: 2),
            //     Text(
            //       'Purchased item',
            //       style: TextStyle(
            //         fontSize: 13,
            //         color: secondaryTextColor,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ],
            // ),
            const SizedBox(height: 6),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(
                review.review,
                softWrap: true,
                // maxLines: 10,
                // overflow: TextOverflow.visible,
                style: const TextStyle(
                  fontSize: 14,
                  color: secondaryTextColor,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ],
    );
  }
}

class Stars extends StatelessWidget {
  final int rate;
  final double size;
  const Stars({super.key, required this.rate, required this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) => Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Icon(
            index < rate ? CupertinoIcons.star_fill : CupertinoIcons.star,
            color: Colors.yellow[600],
            size: size,
          ),
        ),
      ),
    );
  }
}
