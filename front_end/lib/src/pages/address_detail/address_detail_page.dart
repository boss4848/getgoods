import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';

class AddressDetailPage extends StatelessWidget {
  const AddressDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'My Address',
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                fontFamily: 'SFTHONBURI'),
          ),
          backgroundColor: primaryColor,
        ),
        body: const Center(child: Text("My Address Page")));
  }
}
