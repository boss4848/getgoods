import 'package:flutter/material.dart';

//for order tracking problem
class oProblemDetailWidget extends StatelessWidget {
  final String typeP;

  const oProblemDetailWidget({Key? key, required this.typeP}) : super(key: key);

  List<Item> generateItems() {
    return [
      Item(
        headerText: 'How can I track the status of my order?',
        bodyText:
            'To track the status of your order, log in to your account and navigate to the "Profile" section and go click “My Purchase”.  You will find a list of your recent orders along with their order status showed in their section. The order tracking number will be assigned if the order status was delivered, and you could view the shipment\'s progress and estimated delivery date.',
      ),
      Item(
        headerText: 'What shipping carriers are used for order delivery?',
        bodyText:
            'We work with trusted shipping carriers to ensure reliable and timely order delivery. The specific carrier used for your order depends on various factors, including the seller\'s location, shipping method chosen, and destination. Common carriers we collaborate with include Kerry express, Flash express and Thailand Post services.',
      ),
      Item(
        headerText:
            'How long does it typically take for an order to be delivered?',
        bodyText:
            'The delivery time of an order varies depending on several factors, such as the seller\'s location, the shipping method selected, and the destination address. During the checkout process, an estimated delivery timeframe will be provided. However, please note that unexpected circumstances or customs procedures may cause slight delays.',
      ),
      Item(
          headerText:
              'Can I change the shipping address for my order after it has been placed?',
          bodyText:
              'Once an order has been placed, changing the shipping address may not be possible, especially if the order has already been shipped. We recommend contacting the seller directly to discuss any changes or exceptions. If the order is still in processing, the seller may be able to assist you in updating the shipping address.'),
      Item(
          headerText:
              'What should I do if my order hasn\'t arrived within the estimated delivery time?',
          bodyText:
              'If your order hasn\'t arrived within the estimated delivery time, we recommend first checking the tracking information provided for any updates or delivery exceptions. If there are no updates or if you have concerns, contact the seller to inquire about the status of your order. They will assist you in tracking down the package or initiating any necessary actions.'),
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
