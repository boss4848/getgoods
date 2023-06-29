import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:getgoods/src/common_widgets/loading_dialog.dart';
import 'package:getgoods/src/pages/my_purchase/widgets/completed.dart';
import 'package:getgoods/src/pages/my_purchase/widgets/to_receive.dart';
import 'package:getgoods/src/pages/my_purchase/widgets/to_ship.dart';
import 'package:getgoods/src/pages/my_purchase/widgets/unpaid_list.dart';
import 'package:getgoods/src/viewmodels/transaction_viewmodel.dart';

import '../../models/transaction_model.dart';

class MyPurchasePage extends StatefulWidget {
  const MyPurchasePage({
    super.key,
    required this.tabIndex,
  });

  final int tabIndex;

  @override
  State<MyPurchasePage> createState() => _MyPurchasePageState();
}

class _MyPurchasePageState extends State<MyPurchasePage> {
  late List<Transaction> transactions;
  late List<Transaction> unpaidTransactions;
  late List<Transaction> toShipTransactions;
  TransactionViewModel transactionViewModel = TransactionViewModel();
  @override
  void initState() {
    super.initState();
    getTransactions();
  }

  getTransactions() async {
    await transactionViewModel.getAllTransactions();
    setState(() {
      transactions = transactionViewModel.transactions;
      unpaidTransactions = transactionViewModel.unpaidTransactions;
      toShipTransactions = transactionViewModel.paidTransactions;
    });
    log(transactions.length.toString());
    // ignore: use_build_context_synchronously
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.tabIndex,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              fontFamily: 'SFTHONBURI',
            ),
            'My purchases',
          ),
          bottom: TabBar(
            isScrollable: true,
            //padding: EdgeInsets.symmetric(horizontal: 10),
            unselectedLabelColor: Colors.white,
            labelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.grey[200],
            ),
            indicatorPadding: const EdgeInsets.symmetric(vertical: 10),
            tabs: const [
              Tab(text: 'To pay'),
              Tab(text: 'To ship'),
              Tab(text: 'To receive'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            UnpaidList(
              transactions: unpaidTransactions,
            ),
            const ToShipList(),
            const ToReceiveList(),
            const CompletedList()
          ],
        ),
      ),
    );
  }
}
