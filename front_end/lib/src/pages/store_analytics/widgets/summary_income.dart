import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/constants/constants.dart';

class SummaryIncomeInfo extends StatelessWidget {
  const SummaryIncomeInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(defaultpadding),
      ),
      child: Padding(
        padding: const EdgeInsets.all(defaultpadding),
        child: Column(
          children: const [
            detailInfo(
              title: 'All item sold',
              data: '0',
              unit: 'items',
              fSize: 20,
            ),
            SizedBox(
              height: defaultpadding / 2,
            ),
            detailInfo(
                title: 'Total income', data: '100000', unit: '฿', fSize: 20),
            SizedBox(
              height: defaultpadding / 2,
            ),
            detailInfo(title: 'Fee Rate', data: '15', unit: '%', fSize: 28),
            SizedBox(
              height: defaultpadding / 2,
            ),
            Borderline(),
            SizedBox(
              height: defaultpadding / 2,
            ),
            Text(
              'TOTAL NET INCOME',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w400,
                fontFamily: 'SFTHONBURI',
              ),
            ),
            Text(
              '15000' '฿',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w700,
                fontFamily: 'SFTHONBURI',
              ),
            )
          ],
        ),
      ),
    );
  }
}

class detailInfo extends StatelessWidget {
  const detailInfo(
      {super.key,
      required this.title,
      required this.data,
      required this.unit,
      required this.fSize});
  final String title;
  final String data;
  final String unit;
  final double fSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: fSize,
            fontWeight: FontWeight.w400,
            fontFamily: 'SFTHONBURI',
          ),
        ),
        Row(
          children: [
            Text(
              data,
              style: TextStyle(
                color: Colors.white,
                fontSize: fSize,
                fontWeight: FontWeight.w700,
                fontFamily: 'SFTHONBURI',
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              unit,
              style: TextStyle(
                color: Colors.white,
                fontSize: fSize,
                fontWeight: FontWeight.w400,
                fontFamily: 'SFTHONBURI',
              ),
            )
          ],
        )
      ],
    );
  }
}

class Borderline extends StatelessWidget {
  const Borderline({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
