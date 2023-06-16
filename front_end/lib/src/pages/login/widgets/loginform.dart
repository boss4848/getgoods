import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/constants.dart';
import 'package:getgoods/src/viewmodels/user_viewmodel.dart';

import '../../../constants/colors.dart';
import '../../signup/signup_page.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserViewModel _userViewModel = UserViewModel();
  bool _obscurePassword = true;
  FocusNode myFocusNode = new FocusNode();
  //late FocusNode _focusNode;

  // @override
  // void initState() {
  //   super.initState();
  //   _focusNode = FocusNode();
  // }

  Future<void> _login() async {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      return;
    }

    // Capture the context in a local variable
    final BuildContext capturedContext = context;

    final String res = await _userViewModel.login(username, password);
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
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    //_focusNode.dispose();
    super.dispose();
  }

  // void _requestFocus() {
  //   setState(() {
  //     FocusScope.of(context).requestFocus(_focusNode);
  //   });
  // }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text;
      String password = _passwordController.text;
      // Apis call
      print('Username: $username');
      print('Password: $password');
    }
  }

  void _navigateToSignUpPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            focusNode: myFocusNode,
            controller: _usernameController,
            style:
                const TextStyle(color: Colors.white, fontFamily: 'SFTHONBURI'),
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(
                  color: myFocusNode.hasFocus ? Colors.white : secondaryColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(color: Colors.white)),
              prefixIcon: const Icon(
                Icons.email_rounded,
                color: secondaryColor,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _passwordController,
            style:
                const TextStyle(color: Colors.white, fontFamily: 'SFTHONBURI'),
            decoration: InputDecoration(
              focusColor: Colors.white,
              labelText: 'Password',
              labelStyle: TextStyle(
                  color: myFocusNode.hasFocus ? Colors.white : secondaryColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.white)),
              prefixIcon: Icon(Icons.lock, color: secondaryColor),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
                child: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  color: secondaryColor,
                ),
              ),
            ),
            obscureText: _obscurePassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          const SizedBox(height: defaultpadding * 1.7),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _submitForm();
                _login();
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                foregroundColor:
                    MaterialStateProperty.all<Color>(secondaryColor),
                shadowColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'SFTHONBURI'),
                ),
              ),
            ),
          ),
          SizedBox(
            height: defaultpadding / 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an account? ",
                style: TextStyle(color: Colors.white, fontFamily: 'SFTHONBURI'),
              ),
              GestureDetector(
                onTap: _navigateToSignUpPage,
                child: const Text(
                  'Sign up now',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontFamily: 'SFTHONBURI',
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
