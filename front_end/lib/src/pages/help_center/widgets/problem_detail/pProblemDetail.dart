import 'package:flutter/material.dart';

//for payment methods problem
class pProblemDetailWidget extends StatelessWidget {
  final String typeP;

  const pProblemDetailWidget({Key? key, required this.typeP}) : super(key: key);

  List<Item> generateItems() {
    return [
      Item(
        headerText: 'What payment methods are accepted on our application?',
        bodyText:
            'We currently accept various payment methods, including credit/debit cards, and bank transfers. The available payment options will be displayed during the checkout process. Choose the one that suits you best and follow the instructions to complete your payment securely.',
      ),
      Item(
        headerText: 'Is my payment information secure on the application?',
        bodyText:
            'Absolutely. We prioritize the security of your payment information. We utilize encryption technology and follow industry best practices to protect your sensitive data. Your payment details are securely transmitted and processed through our trusted payment gateway partners, ensuring a safe and reliable transaction experience.',
      ),
      Item(
        headerText: 'Can I save my payment information for future purchases?',
        bodyText:
            'For your convenience, we offer the option to securely save your payment information in your account. This allows for faster checkout on future purchases. Rest assured that we adhere to strict privacy policies and take all necessary measures to protect your stored payment details.',
      ),
      Item(
          headerText:
              'Are there any additional fees or charges for using a specific payment method?',
          bodyText:
              'We do not impose any additional fees or charges for using a specific payment method. However, it is advisable to check with your financial institution or payment provider for any applicable fees or currency conversion charges that they may impose.'),
      Item(
          headerText:
              'What should I do if I encounter payment-related issues during checkout?',
          bodyText:
              'If you experience any payment-related issues during checkout, please ensure that you have entered the correct payment details and that your payment method is valid. If the problem persists, contact our customer support team for assistance. They will help troubleshoot the issue and guide you through the payment process.'),
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
