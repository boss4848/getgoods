import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/pages/login/widgets/appbar.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primaryColor,
        child: SafeArea(
            child: Column(
          children: [
            TitleAppBar(titleName: 'Sign Up'),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [Text('Sign up page')],
              ),
            ))
          ],
        )),
      ),
    );
  }
}
