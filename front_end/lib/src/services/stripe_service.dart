import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:getgoods/src/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stripe_checkout/stripe_checkout.dart';

class StripeService {
  static String secretKey =
      "sk_test_51NFv6LI5fmkNEzwdosGj61RLnpVMBiCkonwR5bvu6RllZ72CSelOQBtc8VaoFtan7OaMOkYXByzWCSUI6fjzoJZA00H6d07Oef";
  static String publishableKey =
      "pk_test_51NFv6LI5fmkNEzwdrcyz5ZjUv0v6rYjaaRxYoYTe2gXRy5n4TNqOhZstiYtBZYn0ef5HnfQm0AY1VTyY8IOWr32t00OFo9a9e8";
  static final Dio _dio = Dio();

  static Future<dynamic> createCheckoutSession(
    List<dynamic> productItems,
    totalAmount,
  ) async {
    final url = Uri.parse("https://api.stripe.com/v1/checkout/sessions");

    String lineItems = "";
    int index = 0;

    productItems.forEach((product) {
      var productPrice = (product['productPrice'] * 100).round().toString();
      lineItems +=
          "&line_items[$index][price_data][product_data][name]=${product['productName']}";

      lineItems += "&line_items[$index][price_data][unit_amount]=$productPrice";
      lineItems += "&line_items[$index][price_data][currency]=EUR";
      lineItems += "&line_items[$index][quantity]=${product['qty'].toString()}";
      index++;
      // lineItems +=
      //     "&line_items[$index][price_data][product_data][name]=${product['productName']}&line_items[$index][price_data][unit_amount]=$productPrice";
    });

    final response = await http.post(
      url,
      body:
          'success_url=https://checkout.stripe.dev/success&mode=payment$lineItems',
      headers: {
        'Authorization': 'Bearer $secretKey',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    return json.decode(response.body)['id'];
  }

  static Future<dynamic> stripePaymentCheckout(
    productItems,
    subTotal,
    context,
    mounted, {
    onSuccess,
    onError,
    onCancel,
  }) async {
    final String sessionId = await createCheckoutSession(
      productItems,
      subTotal,
    );
    log(sessionId);

    Future<String?> _getToken() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('token');
    }

    void _setAuthToken(String? token) {
      if (token == null) {
        throw Exception('No token found');
      }
      _dio.options.headers['Authorization'] = 'Bearer $token';
    }

    // create transaction
    final String createTransactionUrl = '${ApiConstants.baseUrl}/transactions';
    log(createTransactionUrl);

    final String? token = await _getToken();
    _setAuthToken(token);

    try {
      final response = await _dio.post(
        createTransactionUrl,
        data: {
          "amount": subTotal,
          "sessionId": sessionId,
        },
      );

      final result = await redirectToCheckout(
        context: context,
        sessionId: sessionId,
        publishableKey: publishableKey,
        successUrl: "https://checkout.stripe.dev/success",
        canceledUrl: "https://checkout.stripe.dev/cancel",
      );
      // log(response.data);
      String transactionId = response.data['transaction']['id'];
      if (mounted) {
        final text = result.when(
          redirected: () => 'Redirected Successfuly',
          success: () async {
            final String updateTransactionUrl =
                '${ApiConstants.baseUrl}/transactions/updateCharge/$transactionId';

            _setAuthToken(token);

            try {
              final response = await _dio.patch(
                updateTransactionUrl,
                data: {
                  "sessionId": sessionId,
                },
              );
            } on DioException catch (e) {
              log(e.message!);
            }
            return onSuccess();
          },
          canceled: () async {
            final String cancelTransactionUrl =
                '${ApiConstants.baseUrl}/transactions/cancel/$transactionId';

            _setAuthToken(token);

            try {
              final response = await _dio.patch(
                cancelTransactionUrl,
                data: {
                  "sessionId": sessionId,
                },
              );
            } on DioException catch (e) {
              log(e.message!);
            }
            return onCancel();
          },
          error: (e) => onError(e),
        );
        return text;
      }
    } on DioException catch (e) {
      log(e.message!);
    }
  }
}
