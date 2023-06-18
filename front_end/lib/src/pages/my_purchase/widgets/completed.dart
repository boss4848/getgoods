import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getgoods/src/pages/home/widgets/content.dart';
import 'package:intl/intl.dart';

import '../../../constants/colors.dart';

class CompletedOrder extends StatefulWidget {
  const CompletedOrder({super.key});

  @override
  State<CompletedOrder> createState() => _CompleteOrderState();
}

class _CompleteOrderState extends State<CompletedOrder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: [
          const SizedBox(height: 6),
          _buildCompleted(
              name: 'Product name',
              price: 1000,
              quantity: 10,
              parcel: '4567ujf38h833fh',
              date: DateFormat.yMd().add_jm()),
          _buildCompleted(
              name: 'Product name',
              price: 1000,
              quantity: 10,
              parcel: '4567ujf38h833fh',
              date: DateFormat.yMd().add_jm()),
          _buildCompleted(
              name: 'Product name',
              price: 1000,
              quantity: 10,
              parcel: '4567ujf38h833fh',
              date: DateFormat.yMd().add_jm()),
        ],
      ),
    );
  }

  Container _buildCompleted({
    required String name,
    required double price,
    required int quantity,
    required String parcel,
    required DateFormat date,
  }) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), 
          color: Colors.grey[300]),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 60,
            width: 60,
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
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Price: $price',
                style: const TextStyle(
                  fontSize: 13,
                  color: secondaryTextColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Amout: $quantity',
                style: const TextStyle(
                  fontSize: 13,
                  color: secondaryTextColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Parcel no: $parcel',
                style: const TextStyle(
                  fontSize: 13,
                  color: secondaryTextColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$date',
                style: const TextStyle(
                  fontSize: 13,
                  color: secondaryTextColor,
                ),
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white)
              ),
              onPressed: () {},
              child: Text(
                style: TextStyle(
                  fontWeight: FontWeight.w100
                ),'Review'),
            ),
          )
        ],
      ),
    );
  }
}
