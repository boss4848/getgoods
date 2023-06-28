import 'dart:convert';
import 'dart:developer';
import 'package:getgoods/src/services/api_service.dart';
import 'package:getgoods/src/constants/constants.dart';
import 'package:stripe_checkout/stripe_checkout.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/product_model.dart';

class CheckoutResponse {
  final String sessionId;
  final String transactionId;

  CheckoutResponse({
    required this.sessionId,
    required this.transactionId,
  });
}

class StripeService {
  static Future<CheckoutResponse> createCheckoutSession(
    List<CheckoutProduct> products,
  ) async {
    final url = '${ApiConstants.baseUrl}/payments';

    final body = {
      'products': products
          .map((product) => {
                'id': product.id,
                'name': product.name,
                'images': product.imageCover,
                'price': product.price,
                'quantity': product.quantity,
              })
          .toList(),
      //double
      'amount': products.fold(
        0,
        (total, product) => total + product.price.toInt(),
      ),
      "shipping_cose": 40,
      // "shipping": {
      //   "name": "Jenny Rosen",
      //   "address": {
      //     "line1": "510 Townsend St",
      //     "postal_code": "98140",
      //     "city": "San Francisco",
      //     "state": "CA",
      //     "country": "US"
      //   }
      // },
    };

    // final body = {
    //   "products": [
    //     {
    //       "id": "6495b956f2e406fc686299fb",
    //       "name": "Fake Golden Takrasan",
    //       "images":
    //           "https://getgoods.blob.core.windows.net/product-photos/default.jpeg",
    //       "price": 1000,
    //       "quantity": 1,
    //     }
    //   ],
    //   "amount": 1000,
    // };

    try {
      final response = await ApiService.request(
        'POST',
        url,
        requiresAuth: true,
        data: body,
      );
      return CheckoutResponse(
        sessionId: response['sessionId'] as String,
        transactionId: response['transactionId'] as String,
      );
    } catch (e) {
      log('Failed to create checkout session: $e');
      throw Exception('Failed to create checkout session');
    }
  }

  static Future<dynamic> stripePaymentCheckout(
    List<CheckoutProduct> products,
    subTotal,
    context,
    mounted, {
    onSuccess,
    onError,
    onCancel,
  }) async {
    final CheckoutResponse response = await createCheckoutSession(products);

    final result = await redirectToCheckout(
      context: context,
      sessionId: response.sessionId,
      publishableKey: dotenv.env['STRIPE_PUBLISHABLE_KEY']!,
      successUrl: "https://checkout.stripe.dev/success",
      canceledUrl: "https://checkout.stripe.dev/cancel",
    );

    if (mounted) {
      final text = result.when(
        redirected: () => 'Redirected successfuly',
        success: () async {
          //update transaction
          final url = '${ApiConstants.baseUrl}/payments/updatecharge';
          final body = {
            "sessionId": response.sessionId,
            "transactionId": response.transactionId,
          };
          await ApiService.request(
            'POST',
            url,
            requiresAuth: true,
            data: body,
          );
          return onSuccess();
        },
        canceled: () => onCancel(),
        error: (e) => onError(e),
      );

      return text;
    }
  }
}
// import 'dart:convert';
// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:getgoods/src/constants/constants.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:stripe_checkout/stripe_checkout.dart';

// class StripeService {
//   static String secretKey =
//       "sk_test_51NFv6LI5fmkNEzwdosGj61RLnpVMBiCkonwR5bvu6RllZ72CSelOQBtc8VaoFtan7OaMOkYXByzWCSUI6fjzoJZA00H6d07Oef";
//   static String publishableKey =
//       "pk_test_51NFv6LI5fmkNEzwdrcyz5ZjUv0v6rYjaaRxYoYTe2gXRy5n4TNqOhZstiYtBZYn0ef5HnfQm0AY1VTyY8IOWr32t00OFo9a9e8";
//   static final Dio _dio = Dio();

//   static Future<dynamic> createCheckoutSession(
//     List<dynamic> productItems,
//     totalAmount,
//   ) async {
//     final url = Uri.parse("https://api.stripe.com/v1/checkout/sessions");

//     String lineItems = "";
//     int index = 0;

//     productItems.forEach((product) {
//       var productPrice = (product['productPrice'] * 100).round().toString();
//       lineItems +=
//           "&line_items[$index][price_data][product_data][name]=${product['productName']}";

//       lineItems += "&line_items[$index][price_data][unit_amount]=$productPrice";
//       lineItems += "&line_items[$index][price_data][currency]=EUR";
//       lineItems += "&line_items[$index][quantity]=${product['qty'].toString()}";
//       index++;
//       // lineItems +=
//       //     "&line_items[$index][price_data][product_data][name]=${product['productName']}&line_items[$index][price_data][unit_amount]=$productPrice";
//     });

//     final response = await http.post(
//       url,
//       body:
//           'success_url=https://checkout.stripe.dev/success&mode=payment$lineItems',
//       headers: {
//         'Authorization': 'Bearer $secretKey',
//         'Content-Type': 'application/x-www-form-urlencoded',
//       },
//     );

//     return json.decode(response.body)['id'];
//   }

//   static Future<dynamic> stripePaymentCheckout(
//     productItems,
//     subTotal,
//     context,
//     mounted, {
//     onSuccess,
//     onError,
//     onCancel,
//   }) async {
//     final String sessionId = await createCheckoutSession(
//       productItems,
//       subTotal,
//     );
//     log(sessionId);

//     final result = await redirectToCheckout(
//       context: context,
//       sessionId: sessionId,
//       publishableKey: publishableKey,
//       successUrl: "https://checkout.stripe.dev/success",
//       canceledUrl: "https://checkout.stripe.dev/cancel",
//     );
//     // log(response.data);
//     if (mounted) {
//       final text = result.when(
//         redirected: () => 'Redirected Successfuly',
//         success: () => onSuccess(),
//         canceled: () => onCancel(),
//         error: (e) => onError(e),
//       );
//       return text;
//     }
//   }
// }
