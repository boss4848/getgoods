import 'package:flutter/material.dart';

//for store usage problem
class sProblemDetailWidget extends StatelessWidget {
  final String typeP;

  const sProblemDetailWidget({Key? key, required this.typeP}) : super(key: key);

  List<Item> generateItems() {
    return [
      Item(
        headerText: 'How do I create a store on our application?',
        bodyText:
            'To create a store, go to our application\'s homepage, click on the "Profile" at the bar and click on the "My Store" button. Follow the step-by-step instructions to set up your store profile, add product listings, and customize your store\'s branding. Once created, your store will be visible to potential buyers on our platform.',
      ),
      Item(
        headerText:
            'Can I customize the appearance of my store\'s profile page?',
        bodyText:
            'Yes, you can customize the appearance of your store\'s profile page to reflect your brand identity. You can upload a store logo, choose a visually appealing theme, and write a compelling store description. These customization options help create a unique and engaging shopping experience for your customers',
      ),
      Item(
        headerText:
            'Are there any restrictions on the types of items that can be listed on the store?',
        bodyText:
            'We dedicate to promote the small seller to be grow in their career. So, the store would only place the hand work product or equipment, process foods.',
      ),
      Item(
          headerText:
              'How can I track the performance and analytics of my store?',
          bodyText:
              'We provide comprehensive analytics tools to help you track the performance of your store. From the store dashboard, you can access data such as sales reports, revenue report, and traffic statistics. These analytics enable you to make informed decisions, optimize your store, and improve your overall business performance.'),
      Item(
          headerText:
              'How do I manage inventory and product/service listings in my store?',
          bodyText:
              'Managing inventory and product listings is easy with our application. After creating your store, you can access your store\'s dashboard, where you\'ll find options to add, edit, and remove listings. You can also manage inventory levels, update product descriptions, and set pricing details from the dashboard.'),
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
