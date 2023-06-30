import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/constants/constants.dart';

class SummaryIncomeInfo extends StatelessWidget {
  final String soldItems;
  final String totalIncome;
  final String totalNetIncome;
  const SummaryIncomeInfo({
    super.key,
    required this.soldItems,
    required this.totalIncome,
    required this.totalNetIncome,
  });

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
          children: [
            detailInfo(
              title: 'All item sold',
              data: soldItems,
              unit: 'items',
              fSize: 20,
            ),
            const SizedBox(
              height: defaultpadding / 2,
            ),
            detailInfo(
                title: 'Total income', data: totalIncome, unit: '฿', fSize: 20),
            const SizedBox(
              height: defaultpadding / 2,
            ),
            detailInfo(title: 'Fee Rate', data: '15', unit: '%', fSize: 28),
            const SizedBox(
              height: defaultpadding / 2,
            ),
            horizontalBorderline(),
            const SizedBox(
              height: defaultpadding / 2,
            ),
            const Text(
              'TOTAL NET INCOME',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w400,
                fontFamily: 'SFTHONBURI',
              ),
            ),
            Text(
              '$totalNetIncome ฿',
              style: const TextStyle(
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

class horizontalBorderline extends StatelessWidget {
  const horizontalBorderline({super.key});

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
