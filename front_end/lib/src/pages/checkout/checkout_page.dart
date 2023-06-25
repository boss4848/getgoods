// import 'dart:convert';
// import 'dart:developer';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../constants/constants.dart';

// class CheckoutPage extends StatelessWidget {
//   const CheckoutPage({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     final Dio _dio = Dio();
//     Future<String?> _getToken() async {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       return prefs.getString('token');
//     }

//     void _setAuthToken(String? token) {
//       if (token == null) {
//         throw Exception('No token found');
//       }
//       _dio.options.headers['Authorization'] = 'Bearer $token';
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Flutter Payments'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 30),
//           child: SizedBox(
//             height: 60,
//             width: double.infinity,
//             child: Container(
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   transform: GradientRotation(20),
//                   colors: <Color>[
//                     Color(0xFF439cfb),
//                     Color(0xFFf187fb),
//                   ],
//                 ),
//               ),
//               child: TextButton(
//                 style: TextButton.styleFrom(
//                   padding: const EdgeInsets.all(16.0),
//                   // backgroundColor: Colors.blue,
//                   textStyle: const TextStyle(fontSize: 20),
//                 ),
//                 onPressed: () async {
//                   final url = Uri.parse(
//                     "${ApiConstants.baseUrl}/buyings/transactions",
//                   );
//                   final body = jsonEncode({
//                     "amount": 100,
//                   });
//                   final String? token = await _getToken();
//                   _setAuthToken(token);

//                   try {
//                     final response = await _dio.post(
//                       url.toString(),
//                       data: body,
//                     );
//                     print(response.data);

//                     Map<String, dynamic> jsonBody = response.data
//                         as Map<String, dynamic>; // Cast to Map<String, dynamic>
//                     Map<String, dynamic>? paymentIntentData;
//                     paymentIntentData = jsonBody;
//                     if (paymentIntentData["paymentIntent"] != null) {
//                       Map<String, dynamic> paymentIntent =
//                           paymentIntentData["paymentIntent"];
//                       String clientSecret = paymentIntent["client_secret"];
//                       // String buyerEmail =
//                       //     "buyer@example.com"; // Replace with actual buyer's email
//                       // String buyerUsername =
//                       //     "buyer123"; // Replace with actual buyer's username
//                       await Stripe.instance.initPaymentSheet(
//                         paymentSheetParameters: SetupPaymentSheetParameters(
//                           paymentIntentClientSecret: clientSecret,
//                           style: ThemeMode.light,
//                           billingDetails: const BillingDetails(
//                             name: 'Passakorn Puttama',
//                             email: 'boss4848988@gmail.com',
//                             phone: '0643132586',
//                           ),

//                           // billingDetails: BillingDetails(
//                           //   email: buyerEmail,
//                           //   name: buyerUsername,
//                           // ),
//                         ),
//                       );
//                       await Stripe.instance.presentPaymentSheet();
//                     }
//                   } on DioException catch (e) {
//                     log('message: ${e.message}');
//                   }
//                 },
//                 child: const Text(
//                   'Stripe',
//                   style: TextStyle(
//                     fontSize: 25,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../../services/stripe_service.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout Page'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            var items = [
              {
                "productPrice": 4,
                "productName": "Apple",
                "qty": 2,
              },
              {
                "productPrice": 5,
                "productName": "Pineapple",
                "qty": 10,
              }
            ];
            await StripeService.stripePaymentCheckout(
              items,
              500,
              context,
              mounted,
              onSuccess: () => print('Success'),
              onCancel: () => print('Cancel'),
              onError: (e) => print("Error: " + e),
            );
          },
          child: const Text('Checkout'),
        ),
      ),
    );
  }
}
