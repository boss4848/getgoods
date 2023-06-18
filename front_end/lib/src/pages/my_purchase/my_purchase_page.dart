import 'package:flutter/material.dart';
import 'package:getgoods/src/pages/my_purchase/widgets/completed.dart';
import 'package:getgoods/src/pages/my_purchase/widgets/to_receive.dart';
import 'package:getgoods/src/pages/my_purchase/widgets/to_ship.dart';
import 'package:getgoods/src/pages/my_purchase/widgets/unpaid_list.dart';

class MyPurchasePage extends StatelessWidget {
  const MyPurchasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Purchases',
        home: DefaultTabController(
            length: 4,
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.green,
                  elevation: 0,
                  title: const Text(
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'SFTHONBURI'),
                      'My purchases'),
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
                    indicatorPadding: EdgeInsets.symmetric(vertical: 10),
                    tabs: const <Tab>[
                      Tab(text: 'To pay'),
                      Tab(text: 'To ship'),
                      Tab(text: 'To receive'),
                      Tab(text: 'Completed'),
                    ],
                  ),
                ),
                body: const TabBarView(children: [
                  const UnpaidList(),
                  const ToShipList(),
                  const ToReceiveList(),
                  const CompletedList()
                  
                ]))));
  }
}
