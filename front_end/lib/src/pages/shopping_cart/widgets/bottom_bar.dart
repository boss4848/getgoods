import 'package:flutter/material.dart';
import '../../../constants/colors.dart';

class CustomBar extends StatelessWidget {
  const CustomBar({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(0, -1),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: const [
          AnimatedTotalPrice(),
          Expanded(
            child: CheckOutButton(),
          ),
        ],
      ),
    );
  }
}

class CheckOutButton extends StatefulWidget {
  const CheckOutButton({Key? key});

  @override
  _CheckOutButtonState createState() => _CheckOutButtonState();
}

class _CheckOutButtonState extends State<CheckOutButton> {
  bool isChecked = false;
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      color: primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Check Out ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '($quantity)',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedTotalPrice extends StatelessWidget {
  const AnimatedTotalPrice({Key? key});

  @override
  Widget build(BuildContext context) {
    double totalPrice = 20;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: totalPrice == 0 ? 0 : 30,
      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: Text(
          'Total Price: \$${totalPrice.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
