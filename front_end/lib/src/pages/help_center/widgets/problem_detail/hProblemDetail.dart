import 'package:flutter/material.dart';

//for hot issues problem
class HProblemDetailWidget extends StatelessWidget {
  final String typeP;

  const HProblemDetailWidget({Key? key, required this.typeP}) : super(key: key);

  List<Item> generateItems() {
    return [
      Item(
        headerText: 'How does our Getgoods handle seller ratings and reviews?',
        bodyText:
            'Buyers have the opportunity to rate and review sellers based on their experience. These ratings and reviews help build trust and assist other buyers in making informed decisions. ',
      ),
      Item(
        headerText: 'How do I start selling product as a seller?',
        bodyText:
            'You can create your store account by clicking on Profile > My Store. After you complete your store information. You can press the plus button to add the products you want to your listing.',
      ),
      Item(
        headerText:
            'Can I trust the product descriptions and images provided by sellers on our Getgoods?',
        bodyText:
            'While we encourage sellers to provide accurate and detailed product descriptions and images, we also recommend that buyers exercise their due diligence. Reading customer reviews, comparing listings, and asking questions directly to sellers can help ensure a satisfactory purchase experience.',
      ),
      Item(
          headerText:
              'Are there any fees or charges associated with using our Getgoods?',
          bodyText:
              'Using our Getgoods is generally free for buyers. However, sellers may incertain fees or charges for listing products or services, such as transaction fees or commissions on sales. These details can be found in the seller terms and conditions or during the registration process for sellers.'),
      Item(
          headerText:
              'How does our Getgoods handle shipping and delivery of products?',
          bodyText:
              'Shipping and delivery processes are managed by the individual sellers on our marketplace. Each seller may have their own shipping methods, rates, and estimated delivery times. When making a purchase, the product listing will typically include information on shipping options and associated costs.'),
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
