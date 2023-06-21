import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/constants/constants.dart';
import 'package:getgoods/src/pages/login/widgets/appbar.dart';

import 'widgets/signup_form.dart';

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
            const TitleAppBar(titleName: 'Sign Up'),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: defaultpadding * 1.5, top: defaultpadding * 1.5),
                    child: Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Create Account,',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'SFTHONBURI'),
                            ),
                            Text(
                              'Sign up to get started!',
                              style: TextStyle(
                                  color: accentColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'SFTHONBURI'),
                            )
                          ],
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(defaultpadding * 2),
                    child: SignUpForm(),
                  ),
                ],
              ),
            ))
          ],
        )),
      ),
    );
  }
}
