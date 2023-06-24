import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/constants/constants.dart';

class MerchandiseSub extends StatelessWidget {
  const MerchandiseSub({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [defaultShadow],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultpadding),
            child: Row(
              children: const [
                Icon(
                  Icons.storefront_rounded,
                  color: primaryColor,
                  size: 30,
                ),
                Text(
                  ' Store Name',
                  style: TextStyle(
                    color: primaryTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'SFTHONBURI',
                  ),
                ),
              ],
            ),
          ),
          const CheckOutProductList(),
        ],
      ),
    );
  }
}

class CheckOutProductList extends StatefulWidget {
  const CheckOutProductList({super.key});

  @override
  State<CheckOutProductList> createState() => _CheckOutProductListState();
}

class _CheckOutProductListState extends State<CheckOutProductList> {
  int totalAmount = 0;
  int totalPrice = 0;

  void updateTotal(int amount, int price) {
    setState(() {
      totalAmount += amount;
      totalPrice += price;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _buildMercProduct(
            name: 'Product name',
            amount: 2,
            price: 1000,
            image: 'https://picsum.photos/200/300',
          ),
          _buildMercProduct(
            name: 'Product name',
            amount: 1,
            price: 1200,
            image: 'https://picsum.photos/200/300',
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: MerchandiseSubtotal(totalAmount: 12, totalPrice: 3000)),
        ],
      ),
    );
  }
}

Container _buildMercProduct({
  required String image,
  required String name,
  required int amount,
  required double price,
}) {
  return Container(
    decoration: BoxDecoration(color: Colors.grey[200]),
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: CachedNetworkImage(
                imageUrl: image,
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
              ),
            ),
            const SizedBox(
              width: defaultpadding / 2,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: primaryTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'SFTHONBURI',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  price.toString() + '฿',
                  style: const TextStyle(
                    color: primaryTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'SFTHONBURI',
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(width: 5),
        Text(
          'x' + amount.toString(),
          style: const TextStyle(
            color: primaryTextColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'SFTHONBURI',
          ),
        )
      ],
    ),
  );
}

class MerchandiseSubtotal extends StatelessWidget {
  final int totalAmount;
  final int totalPrice;

  const MerchandiseSubtotal(
      {Key? key, required this.totalAmount, required this.totalPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Text(
              'Merchandise Subtotal',
              style: TextStyle(
                color: primaryTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: 'SFTHONBURI',
              ),
            ),
            Text(' ($totalAmount items)',
                style: const TextStyle(
                  color: primaryTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'SFTHONBURI',
                )),
          ],
        ),
        Text('$totalPrice ฿',
            style: const TextStyle(
              color: primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              fontFamily: 'SFTHONBURI',
            ))
      ],
    );
  }
}
