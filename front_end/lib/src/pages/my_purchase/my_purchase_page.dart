import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:getgoods/src/common_widgets/loading.dart';
import 'package:getgoods/src/common_widgets/loading_dialog.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/pages/my_purchase/widgets/completed.dart';
import 'package:getgoods/src/pages/my_purchase/widgets/to_receive.dart';
import 'package:getgoods/src/pages/my_purchase/widgets/to_ship.dart';
import 'package:getgoods/src/pages/my_purchase/widgets/transaction_list.dart';
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
  List<Transaction> transactions = [];
  List<Transaction> unpaidTransactions = [];
  List<Transaction> toShipTransactions = [];
  List<Transaction> toReceiveTransactions = [];
  List<Transaction> completedTransactions = [];
  TransactionViewModel transactionViewModel = TransactionViewModel();
  @override
  void initState() {
    super.initState();
    getTransactions();
  }

  getTransactions() async {
    // loadingDialog(context);
    await transactionViewModel.getAllTransactions();
    setState(() {
      transactions = transactionViewModel.transactions;
      unpaidTransactions = transactionViewModel.unpaidTransactions;
      toShipTransactions = transactionViewModel.paidTransactions;
      toReceiveTransactions = transactionViewModel.toReceiveTransactions;
      completedTransactions = transactionViewModel.completedTransactions;
    });
    log(transactions.length.toString());
    // ignore: use_build_context_synchronously
    // Navigator.pop(context);
    // ignore: use_build_context_synchronously
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.tabIndex,
      length: 4,
      child: Scaffold(
        backgroundColor: primaryBGColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              fontFamily: 'SFTHONBURI',
            ),
            'My purchases',
          ),
          bottom: TabBar(
            isScrollable: true,
            //padding: EdgeInsets.symmetric(horizontal: 10),
            unselectedLabelColor: Colors.black.withOpacity(0.7),
            labelColor: primaryColor,
            indicatorColor: primaryColor,
            indicatorSize: TabBarIndicatorSize.tab,

            // indicator: BoxDecoration(
            //   borderRadius: BorderRadius.circular(50),
            //   color: Colors.grey[200],
            // ),
            tabs: [
              Tab(text: 'To pay'),
              Tab(text: 'To ship'),
              Tab(text: 'To receive'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TransactionList(
              transactions: unpaidTransactions,
              getTransactions: getTransactions,
            ),
            TransactionList(
              transactions: toShipTransactions,
              getTransactions: getTransactions,
            ),
            TransactionList(
              transactions: toReceiveTransactions,
              getTransactions: getTransactions,
            ),
            TransactionList(
              transactions: completedTransactions,
              getTransactions: getTransactions,
            ),
            // ToShipList(
            //   transactions: toShipTransactions,
            //   getTransactions: getTransactions,
            // ),
            // const ToReceiveList(),
            // const CompletedList()
          ],
        ),
      ),
    );
  }
}
// 4242424242424242