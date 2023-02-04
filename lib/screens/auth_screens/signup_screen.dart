import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(),
                  TextFormField(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
