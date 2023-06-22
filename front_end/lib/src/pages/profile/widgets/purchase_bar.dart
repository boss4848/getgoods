import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/pages/my_purchase/my_purchase_page.dart';

class PurchasetrackBar extends StatelessWidget {
  const PurchasetrackBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: primaryBGColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            PurchaseIcon(
              icon: Icons.wallet_rounded,
              title: 'To Pay',
              pageRouteto: MyPurchasePage(
                tabIndex: 0,
              ),
            ),
            PurchaseIcon(
              icon: CupertinoIcons.cube_box_fill,
              title: 'To Ship',
              pageRouteto: MyPurchasePage(
                tabIndex: 1,
              ),
            ),
            PurchaseIcon(
              icon: Icons.local_shipping_rounded,
              title: 'To Receive',
              pageRouteto: MyPurchasePage(
                tabIndex: 2,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Borderline extends StatelessWidget {
  const Borderline({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}

class PurchaseIcon extends StatelessWidget {
  const PurchaseIcon({
    Key? key,
    required this.icon,
    required this.title,
    required this.pageRouteto,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final Widget pageRouteto;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => pageRouteto,
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Icon(
                icon,
                size: 28,
                color: Colors.grey,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'SFTHONBURI',
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
