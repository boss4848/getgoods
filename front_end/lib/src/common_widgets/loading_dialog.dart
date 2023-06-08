import 'package:flutter/material.dart';

loadingDialog(BuildContext context) {
  return showDialog(
    barrierColor: Colors.black.withOpacity(0.7),
    context: context,
    builder: (context) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo_2.png",
              width: 100,
            ),
            const SizedBox(height: 10),
            const Text(
              'Loading...',
              style: TextStyle(
                color: Colors.green,
                fontSize: 16,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      );
    },
  );
}
