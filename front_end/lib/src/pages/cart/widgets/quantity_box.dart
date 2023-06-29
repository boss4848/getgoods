import 'package:flutter/material.dart';
import 'package:getgoods/src/common_widgets/loading_dialog.dart';

import '../../../constants/constants.dart';
import '../../../services/api_service.dart';

class QuantityBox extends StatefulWidget {
  final int stock;
  final String cartItemId;
  final int quantity;
  final Function fetchData;

  // final Function updateQuantity;
  const QuantityBox({
    super.key,
    required this.stock,
    required this.cartItemId,
    required this.quantity,
    required this.fetchData,
    // required this.updateQuantity,
  });

  @override
  State<QuantityBox> createState() => _QuantityBoxState();
}

class _QuantityBoxState extends State<QuantityBox> {
  late int updatedQuantity;

  @override
  void initState() {
    super.initState();
    updatedQuantity = widget.quantity;
  }

  Future<void> increaseQuantity() async {
    if (updatedQuantity < widget.stock) {
      // loadingDialog(context);
      await ApiService.request(
        'PATCH',
        '${ApiConstants.baseUrl}/cart/${widget.cartItemId}',
        data: {
          'quantity': (updatedQuantity + 1),
        },
      );
      widget.fetchData();
      setState(() {
        updatedQuantity++;
      });
      // ignore: use_build_context_synchronously
      // Navigator.pop(context);
      // setState(() {
      //   widget.quantity++;
      // });
      // widget.updateQuantity(widget.quantity);
    }
  }

  void decreaseQuantity() {
    if (updatedQuantity > 1) {
      // loadingDialog(context);

      ApiService.request(
        'PATCH',
        '${ApiConstants.baseUrl}/cart/${widget.cartItemId}',
        data: {
          'quantity': (updatedQuantity - 1),
        },
      );
      widget.fetchData();

      setState(() {
        updatedQuantity--;
      });

      // ignore: use_build_context_synchronously
      // Navigator.pop(context);
      // setState(() {
      //   widget.quantity--;
      // });
      // widget.updateQuantity(widget.quantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 124,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: SizedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 30,
                    height: 28,
                    child: IconButton(
                      icon: const Icon(Icons.remove),
                      iconSize: 12,
                      onPressed: () => decreaseQuantity(),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        left: BorderSide(color: Colors.grey),
                        right: BorderSide(color: Colors.grey),
                      ),
                    ),
                    width: 60,
                    height: 28,
                    child: Center(
                      child: Text(
                        updatedQuantity.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                    height: 28,
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      iconSize: 12,
                      onPressed: () => increaseQuantity(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (updatedQuantity >= widget.stock)
            const Text(
              'Maximum Reached',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                fontSize: 10,
                color: Colors.red,
              ),
            ),
        ],
      ),
    );
  }
}
