import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/constants/constants.dart';

class OverAllStoreBar extends StatelessWidget {
  final String orders;
  final String revenues;
  const OverAllStoreBar({
    super.key,
    required this.orders,
    required this.revenues,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(defaultpadding),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            OverAllData(
                icon: Icons.money, title: 'Revenues', data: '$revenues ฿'),
            const Borderline(),
            OverAllData(
                icon: Icons.list_rounded, title: 'Orders', data: orders),
            // const Borderline(),
            // const OverAllData(
            //     icon: Icons.remove_red_eye_rounded,
            //     title: 'Visitors',
            //     data: '0')
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}

class OverAllData extends StatelessWidget {
  const OverAllData(
      {Key? key, required this.icon, required this.title, required this.data})
      : super(key: key);

  final IconData icon;
  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 28,
              color: Colors.white,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'SFTHONBURI',
              ),
            )
          ],
        ),
        Text(
          data,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: 'SFTHONBURI',
          ),
        )
      ],
    );
    ;
  }
}
