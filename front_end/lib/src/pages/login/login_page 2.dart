import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:getgoods/src/viewmodels/user_viewmodel.dart';

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
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true, // This should be added for password fields
              ),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Log in'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
