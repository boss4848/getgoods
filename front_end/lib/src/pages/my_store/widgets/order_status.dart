import 'package:flutter/material.dart';
import 'package:getgoods/src/models/transaction_model.dart';
import 'package:getgoods/src/pages/to_ship/to_ship_page.dart';

import '../../../constants/colors.dart';

class OrderStatus extends StatelessWidget {
  final List<Transaction> transactions;
  const OrderStatus({
    super.key,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    List<String> orderStatus = [
      'To Ship',
      // 'Cancelled',
      'Review',
    ];

    List<Widget> pages = [
      ToShipPage(transactions: transactions),
      Container(),
      Container(),
    ];

    List<int> statusCount = [
      transactions.where((element) => element.status == 'paid').length,
      // transactions.where((element) => element.status == 'Cancelled').length,
      transactions.where((element) => element.status == 'review').length,
    ];

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Status',
            style: TextStyle(
              color: primaryTextColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: List.generate(
              orderStatus.length,
              (index) => Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => pages[index],
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.all(12),
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: primaryColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          statusCount[index].toString(),
                          style: const TextStyle(
                            color: secondaryBGColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // const SizedBox(width: 8),
                        Text(
                          orderStatus[index],
                          style: const TextStyle(
                            color: secondaryBGColor,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
