import 'package:flutter/material.dart';

import '../constants/colors.dart';

class ErrorPage extends StatelessWidget {
  final String pageTitle;
  const ErrorPage({super.key, required this.pageTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      backgroundColor: secondaryBGColor,
      body: const Center(
        child: Text(
          'Error',
          style: TextStyle(
            color: primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
