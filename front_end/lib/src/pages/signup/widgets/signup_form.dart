import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/constants.dart';
import 'package:getgoods/src/pages/login/login_page.dart';

import '../../../constants/colors.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  FocusNode myFocusNode = new FocusNode();
  bool _obscurePassword = true;
  bool _obscureCfPassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitSignUpForm() {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;
      print('Username: $username');
      print('Username: $email');
      print('Password: $password');
    }
  }

  void _navigateToLogInPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
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
            style: const TextStyle(
                color: secondaryColor, fontFamily: 'SFTHONBURI'),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Username',
              labelStyle: const TextStyle(
                  color: secondaryColor, fontFamily: 'SFTHONBURI'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(
                Icons.person,
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
          const SizedBox(
            height: defaultpadding,
          ),
          TextFormField(
            controller: _emailController,
            style: const TextStyle(
                color: secondaryColor, fontFamily: 'SFTHONBURI'),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Email',
              labelStyle: const TextStyle(
                  color: secondaryColor, fontFamily: 'SFTHONBURI'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(
                Icons.mail_rounded,
                color: secondaryColor,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          const SizedBox(
            height: defaultpadding,
          ),
          TextFormField(
            controller: _passwordController,
            style: const TextStyle(
                color: secondaryColor, fontFamily: 'SFTHONBURI'),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Password',
              labelStyle: const TextStyle(
                  color: secondaryColor, fontFamily: 'SFTHONBURI'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: Colors.white),
              ),
              prefixIcon: const Icon(
                Icons.lock,
                color: secondaryColor,
              ),
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
          const SizedBox(
            height: defaultpadding,
          ),
          TextFormField(
            controller: _confirmPasswordController,
            style: const TextStyle(
                color: secondaryColor, fontFamily: 'SFTHONBURI'),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Confirm Password',
              labelStyle: const TextStyle(
                  color: secondaryColor, fontFamily: 'SFTHONBURI'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: Colors.white),
              ),
              prefixIcon: const Icon(
                Icons.lock,
                color: secondaryColor,
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureCfPassword = !_obscureCfPassword;
                  });
                },
                child: Icon(
                  _obscureCfPassword ? Icons.visibility : Icons.visibility_off,
                  color: secondaryColor,
                ),
              ),
            ),
            obscureText: _obscureCfPassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          const SizedBox(
            height: defaultpadding * 1.5,
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _submitSignUpForm();
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                backgroundColor:
                    MaterialStateProperty.all<Color>(secondaryColor),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shadowColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Create Account',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'SFTHONBURI'),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: defaultpadding / 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an account? ",
                style: TextStyle(color: Colors.white, fontFamily: 'SFTHONBURI'),
              ),
              GestureDetector(
                onTap: _navigateToLogInPage,
                child: const Text(
                  'Sign in',
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
