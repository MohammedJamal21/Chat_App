import 'package:flutter/material.dart';

import '../../widgets/auth/signup_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SignupForm(),
            Text('efhfeji'),
          ],
        ),
      ),

    );
  }
}

