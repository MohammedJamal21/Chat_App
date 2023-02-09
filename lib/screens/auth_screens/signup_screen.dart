import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/auth/signup_form.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final auth = FirebaseAuth.instance;
  bool isLoading = false;

  Future<void> _submitSignUpForm(String email, String password) async {
    UserCredential userCredential;

    try {
      setState(() {
        isLoading = true;
      });
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      setState(() {
        isLoading = false;
      });
    } catch (error) {}
  }

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
