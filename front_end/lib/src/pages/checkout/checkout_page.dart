import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

import '../../constants/constants.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Payments'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SizedBox(
            height: 60,
            width: double.infinity,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  transform: GradientRotation(20),
                  colors: <Color>[
                    Color(0xFF439cfb),
                    Color(0xFFf187fb),
                  ],
                ),
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  primary: Colors.white,
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () async {
                  final url = Uri.parse(
                      "${ApiConstants.baseUrl}/buyings/craete-payment-intent/?amount=7000&currency=thb");
                  final response = await http.get(url);
                  print(response.body);
                  var jsonBody = jsonDecode(response.body);
                  Map<String, dynamic>? paymentIntentData;
                  paymentIntentData = jsonBody;
                  if (paymentIntentData!["paymentIntent"] != "" &&
                      paymentIntentData["paymentIntent"] != null) {
                    String _clientSecret =
                        paymentIntentData["paymentIntent"]["client_secret"];
                    String _productName =
                        "Product Name"; // Replace with actual product name
                    String _productImageURL =
                        "https://example.com/product-image.jpg"; // Replace with actual product image URL
                    String _merchantName =
                        "Merchant Name"; // Replace with actual merchant/store name
                    String _buyerEmail =
                        "buyer@example.com"; // Replace with actual buyer's email
                    String _buyerUsername =
                        "buyer123"; // Replace with actual buyer's username
                    int _amount =
                        700000; // Replace with actual amount in the smallest currency unit (e.g., cents)

                    await Stripe.instance.initPaymentSheet(
                      paymentSheetParameters: SetupPaymentSheetParameters(
                        paymentIntentClientSecret: _clientSecret,
                        // merchantDisplayName: _merchantName,
                        style: ThemeMode.light,
                        // merchantDisplayName: 'Test',
                        // primaryButtonLabel: 'Pay $_amount THB',
                        billingDetails: BillingDetails(
                          email: _buyerEmail,
                          name: _buyerUsername,
                        ),
                      ),
                    );

                    await Stripe.instance.presentPaymentSheet();
                  }
                },
                child: const Text(
                  'Stripe',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
