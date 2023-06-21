import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class BankInfoPage extends StatelessWidget {
  const BankInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Banking Account Info',
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                fontFamily: 'SFTHONBURI'),
          ),
          backgroundColor: primaryColor,
        ),
        body: const Center(child: Text("Banking Account Info")));
  }
}
