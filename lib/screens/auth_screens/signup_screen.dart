import 'package:flutter/material.dart';

import '../../widgets/auth/signup_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Sign Up'),
              SizedBox(
                height: 50,
              ),
              SignupForm(),
              SizedBox(
                height: 50,
              ),
              Text('Already have an account? Login'),
            ],
          ),
        ),
      ),

    );
  }
}

