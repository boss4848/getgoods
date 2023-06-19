import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import  'package:intl/intl.dart';

class Notifications extends StatelessWidget {
  Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: secondaryBGColor,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 62,
            left: 12,
            right: 12,
          ),
          child: Column(
            children: List.generate(
              5,
              (index) => _buildNotiItem(
                context: context,
                status: 'Product has been delivered',
                detail: 'Parcel number 12345678 of order 23456sewa32 has been successfully delivered',
                dateTime: dateTime,
                clockTime: clockTime,
              ),
            ),
          ),
        ),
      ),
    );
  }

  String dateTime = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String clockTime = DateFormat("hh:mm a").format(DateTime.now());
  GestureDetector _buildNotiItem({
    context,
    required String status,
    required String detail,
    required dateTime,
    required clockTime,
  }) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 1.5,
              spreadRadius: 0.5,
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             ClipRRect(
              borderRadius:BorderRadius.circular(7),
              child: Image.network(
                'https://img.freepik.com/premium-photo/handcraft-woven-basket-product-thailand-otop-shop-sme-best-thai-quality-sale_43300-791.jpg?w=2000',
                fit: BoxFit.cover,
                height: 50,
                width: 50,
                //color: Colors.black,
              ),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width-150,
                  child: Text(
                    detail,
                    style: const TextStyle(
                      color: secondaryTextColor,
                      fontSize: 13,
                    ),
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                  ),
                ),
                
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      dateTime,
                      style: const TextStyle(
                        color: secondaryTextColor,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox( width: 10),
                    Text(
                      clockTime,
                      style: const TextStyle(
                        color: secondaryTextColor,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
