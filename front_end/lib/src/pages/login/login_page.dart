import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/constants/constants.dart';
import 'package:getgoods/src/pages/login/widgets/appbar.dart';

import '../../viewmodels/user_viewmodel.dart';
import 'widgets/loginform.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserViewModel _userViewModel = UserViewModel();

  Future<void> _login() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      return;
    }

    // Capture the context in a local variable
    final BuildContext capturedContext = context;

    final String res = await _userViewModel.login(email, password);
    if (res != 'success') {
      // ignore: use_build_context_synchronously
      showDialog(
        context: capturedContext,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('An error occurred. $res'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      log('Login successful');
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

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
