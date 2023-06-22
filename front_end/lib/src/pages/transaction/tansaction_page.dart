import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Check Out',
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                fontFamily: 'SFTHONBURI'),
          ),
        ),
        backgroundColor: secondaryBGColor,
        body: Column(
          children: [],
        ));
  }
}
