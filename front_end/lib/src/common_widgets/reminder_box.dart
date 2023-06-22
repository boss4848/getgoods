import 'package:flutter/material.dart';
import '../constants/colors.dart';

class ReminderBox extends StatelessWidget {
  final String title;
  final String message;
  final Function onBoxClose;
  const ReminderBox({
    super.key,
    required this.title,
    required this.message,
    required this.onBoxClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        top: 12,
        left: 12,
        right: 12,
        bottom: 4,
      ),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: primaryColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 1.5,
            spreadRadius: 0.1,
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => onBoxClose(),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
