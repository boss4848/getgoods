import 'package:flutter/material.dart';

//for about getgoods problem
class gProblemDetailWidget extends StatelessWidget {
  final String typeP;

  const gProblemDetailWidget({Key? key, required this.typeP}) : super(key: key);

  List<Item> generateItems() {
    return [
      Item(
        headerText: 'What is the Getgoods?',
        bodyText:
            'Getgoods is the marketplace application which is online platform that connects buyers and sellers, providing a convenient and efficient way to buy and sell a wide range of products and place to sell without middle person. It offers a user-friendly interface and a diverse selection of items from various sellers.',
      ),
      Item(
        headerText: 'How does the Getgoods work?',
        bodyText:
            'Our Getgoods functions as a virtual marketplace where sellers can create listings for their products and buyers can browse, search, and make purchases. Sellers can showcase their offerings with detailed descriptions, pricing, and images, while buyers can explore the listings and make informed decisions by themselves.',
      ),
      Item(
        headerText: 'What are the benefit of using our Getgoods?',
        bodyText:
            'There are several benefits to using our Getgoods. It provides a centralized platform where buyers can access a wide range of products from different sellers, allowing for easy selection wide range of products. It also offers fairly fee from us with no charge, customer reviews and ratings for transparency, and a seamless buying experience.',
      ),
      Item(
          headerText: 'What types of products can I find on our Getgoods?',
          bodyText:
              'Our Getgoods offers a diverse range of products. You can find anything from hand work product or equipment, process foods, and any other from small seller.'),
      Item(
          headerText: 'How can I start using our Getgoods?',
          bodyText:
              'To start using our marketplace application, simply visit our website or download our mobile app from your device\'s app store. Create a user account by providing the required information, such as your name and email address. Once registered, you can explore the listings, make purchases, and engage with sellers.'),
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
