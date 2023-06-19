import 'package:flutter/material.dart';

class ProblemDetailWidget extends StatelessWidget {
  final String typeP;

  const ProblemDetailWidget({Key? key, required this.typeP}) : super(key: key);

  List<Item> generateItems() {
    return [
      Item(
        headerText: 'How do I create an account?',
        bodyText: 'Text',
      ),
      Item(
        headerText: 'How do I start selling product as a seller?',
        bodyText: 'You can create your store account by clicking on Profile > My Store. After you complete your store information. You can press the plus button to add the products you want to your listing.',
      ),
      Item(
        headerText: 'How do I start selling product as a seller?',
        bodyText: 'Item 3 Body',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final List<Item> items = generateItems();
    final List<Widget> itemWidgets = items.map((item) {
      return ExpansionTile(
        textColor: Colors.black,
        iconColor: Colors.black,
        tilePadding: const EdgeInsets.only(left: 0, right: 18),
        title: Text("[$typeP] ${item.headerText}"),
        children: <Widget>[ListTile(title: Text(item.bodyText))],
      );
    }).toList();

    return Column(
      children: itemWidgets,
    );
  }
}

class Item {
  Item({
    required this.headerText,
    required this.bodyText,
  });

  String headerText;
  String bodyText;
}