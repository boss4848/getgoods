import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getgoods/src/models/transaction_model.dart';
import 'package:getgoods/src/pages/my_purchase/widgets/transaction_box.dart';
import 'package:getgoods/src/pages/transaction/tansaction_page.dart';
import 'package:intl/intl.dart';

import '../../../constants/colors.dart';

class TransactionList extends StatefulWidget {
  final Function getTransactions;
  final List<Transaction> transactions;
  const TransactionList({
    super.key,
    required this.transactions,
    required this.getTransactions,
  });

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return widget.transactions.isNotEmpty
        ? SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 6),
                //list
                for (var i = 0; i < widget.transactions.length; i++) ...[
                  TransactionBox(
                    transaction: widget.transactions[i],
                    getTransactions: widget.getTransactions,
                  ),
                ],
                const SizedBox(height: 200)
              ],
            ),
          )
        : const Center(
            child: Text(
              'No transaction',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryTextColor,
              ),
            ),
          );
  }
}
