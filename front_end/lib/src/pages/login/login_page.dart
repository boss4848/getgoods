import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/constants/constants.dart';
import 'package:getgoods/src/pages/login/widgets/appbar.dart';

import 'widgets/loginform.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        alignment: Alignment.center,
        color: primaryColor,
        child: SafeArea(
          child: Column(
            children: [
              const TitleAppBar(
                titleName: 'Login',
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: defaultpadding,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.black12,
                        maxRadius: 100,
                        child: Image.asset('assets/images/logo_2.png'),
                      ),
                      const SizedBox(
                        height: defaultpadding,
                      ),
                      RichText(
                          text: const TextSpan(
                              text: 'Get',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'SFTHONBURI'),
                              children: [
                            TextSpan(
                                text: 'Goods',
                                style: TextStyle(color: accentColor))
                          ])),
                      const Text(
                        'Marketplace for getting goods.',
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'SFTHONBURI'),
                      ),
                      SizedBox(
                        height: defaultpadding,
                      ),
                      Padding(
                        padding: EdgeInsets.all(defaultpadding),
                        child: LoginForm(),
                      ),
                      SizedBox(
                        height: defaultpadding * 3,
                      ),
                      GestureDetector(
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.white,
                              fontFamily: 'SFTHONBURI',
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
