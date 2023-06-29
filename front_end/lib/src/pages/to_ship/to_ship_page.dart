import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/pages/my_purchase/widgets/transaction_box.dart';

import '../../models/transaction_model.dart';
import '../../viewmodels/shop_viewmodel.dart';

class ToShipPage extends StatefulWidget {
  final List<Transaction> transactions;
  const ToShipPage({
    super.key,
    required this.transactions,
  });

  @override
  State<ToShipPage> createState() => _ToShipPageState();
}

class _ToShipPageState extends State<ToShipPage> {
  late ShopViewModel shopViewModel = ShopViewModel();
  List<Transaction> transactions = [];
  @override
  void initState() {
    super.initState();
    shopViewModel = ShopViewModel();
    _getShopDetail();
    transactions = shopViewModel.shop.transactions;
  }

  _getShopDetail() async {
    // print('fetching shop detail');
    await shopViewModel.fetchShop(
      widget.transactions[0].shop.id,
    );
    transactions = shopViewModel.shop.transactions;
    setState(() {});
    // print('fetching shop detail: ${shopViewModel.shop.products.length}');
    // log(res);
    // log(shopViewModel.shopDetail.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBGColor,
      appBar: AppBar(
        title: const Text('To Ship'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //list
            for (var i = 0; i < transactions.length; i++) ...[
              TransactionBox(
                transaction: transactions[i],
                getTransactions: _getShopDetail,
                isOwner: true,
              ),
            ],
            const SizedBox(height: 200)
          ],
        ),
      ),
    );
  }
}
// 42424242424242424