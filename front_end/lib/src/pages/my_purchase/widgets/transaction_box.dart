import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:getgoods/src/common_widgets/shadow_container.dart';
import 'package:getgoods/src/models/transaction_model.dart';
import 'package:getgoods/src/pages/review/review_page.dart';
import 'package:getgoods/src/services/api_service.dart';
import 'package:stripe_checkout/stripe_checkout.dart';
//import timeago
import 'package:timeago/timeago.dart' as timeago;

import '../../../constants/colors.dart';
import '../../../constants/constants.dart';

class TransactionBox extends StatefulWidget {
  final Function getTransactions;
  final Transaction transaction;
  final bool isOwner;
  const TransactionBox({
    super.key,
    required this.transaction,
    required this.getTransactions,
    this.isOwner = false,
  });

  @override
  State<TransactionBox> createState() => _TransactionBoxState();
}

class _TransactionBoxState extends State<TransactionBox> {
  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      padding: false,
      items: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.transaction.shop.name,
                style: const TextStyle(
                  color: primaryTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                timeago.format(widget.transaction.createdAt),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 12,
            right: 12,
            bottom: 12,
          ),
          child: Text('ID: ${widget.transaction.id}'),
        ),
        Container(
          width: double.infinity,
          color: Colors.grey[200],
          padding: const EdgeInsets.all(12),
          child: Column(
            children: List.generate(
              widget.transaction.products.length,
              (index) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: index == widget.transaction.products.length - 1
                        ? 0
                        : 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.network(
                          'https://getgoods.blob.core.windows.net/product-photos/${widget.transaction.products[index].imageCover}',
                          width: 100,
                          height: 100,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.transaction.products[index].name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryTextColor,
                            ),
                          ),
                          // const SizedBox(width: 10),
                          Text(
                            'x${widget.transaction.quantity[index]}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: primaryTextColor,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          // const SizedBox(width: 10),
                          // const Spacer(),
                          Text(
                            '฿${widget.transaction.products[index].price}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          if (widget.transaction.status == 'completed' &&
                              !widget.isOwner)
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ReviewPage(
                                        transactionId: widget.transaction.id,
                                        shopId: widget.transaction.shop.id,
                                        productId: widget
                                            .transaction.products[index].id,
                                        productName: widget
                                            .transaction.products[index].name,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: const Text(
                                'Rate this product',
                              ),
                            ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Status: ${widget.transaction.status}'),
                  const SizedBox(height: 6),
                  Text('Total: ฿${widget.transaction.amount}'),
                  const SizedBox(height: 6),
                  // Text('Shipping Fee: ${transaction.shippingFee}'),
                ],
              ),
              if (widget.transaction.status == 'unpaid')
                ElevatedButton(
                  onPressed: () async {
                    final res = await redirectToCheckout(
                      context: context,
                      sessionId: widget.transaction.sessionId,
                      publishableKey: dotenv.env['STRIPE_PUBLISHABLE_KEY']!,
                      successUrl: "https://checkout.stripe.dev/success",
                      canceledUrl: "https://checkout.stripe.dev/cancel",
                    );
                    if (mounted) {
                      final text = res.when(
                        redirected: () => 'Redirected successfuly',
                        success: () async {
                          final url =
                              '${ApiConstants.baseUrl}/transactions/${widget.transaction.id}';
                          final response = await ApiService.request(
                            'PATCH',
                            url,
                            data: {
                              'status': 'paid',
                            },
                            requiresAuth: true,
                          ).then(
                            (_) => widget.getTransactions(),
                          );
                        },
                        canceled: () => 'cancelled',
                        error: (e) => 'error: $e',
                      );
                    }
                  },
                  child: const Text('Pay Now'),
                ),
              if (widget.transaction.status == 'paid' && !widget.isOwner)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'Waiting for shipping',
                    style: TextStyle(
                      color: Colors.white,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              if (widget.transaction.status == 'paid' && widget.isOwner)
                ElevatedButton(
                  onPressed: () async {
                    final url =
                        '${ApiConstants.baseUrl}/transactions/${widget.transaction.id}';
                    final response = await ApiService.request(
                      'PATCH',
                      url,
                      data: {
                        'status': 'shipped',
                      },
                      requiresAuth: true,
                    ).then(
                      (_) => widget.getTransactions(),
                    );
                  },
                  child: const Text('Update shipping status'),
                ),
              if (widget.transaction.status == 'shipped' && !widget.isOwner)
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Confirm'),
                          content: const Text(
                              'Are you sure you received the product?'),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                final url =
                                    '${ApiConstants.baseUrl}/transactions/${widget.transaction.id}';
                                final response = await ApiService.request(
                                  'PATCH',
                                  url,
                                  data: {
                                    'status': 'completed',
                                  },
                                  requiresAuth: true,
                                ).then(
                                  (_) => widget.getTransactions(),
                                );
                                Navigator.pop(context);
                              },
                              child: const Text('Yes'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('No'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text(
                    'I received the product',
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
