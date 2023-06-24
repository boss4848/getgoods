import 'package:flutter/material.dart';

class ShadowContainer extends StatelessWidget {
  final bool padding;
  final List<Widget> items;
  const ShadowContainer({
    this.padding = true,
    required this.items,
    super.key,
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 1.5,
            spreadRadius: 0.1,
          )
        ],
      ),
      child: Padding(
        padding: padding ? const EdgeInsets.all(12) : const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [...items],
        ),
      ),
    );
  }
}
