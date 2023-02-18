import 'package:flutter/material.dart';

import '../../widgets/auth/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Login'),
              SizedBox(
                height: 50,
              ),
              LoginForm(),
              SizedBox(
                height: 50,
              ),
              Text('Don\'t have an account? Sign up'),
            ],
          ),
        ),
      ),
    );
  }
}
