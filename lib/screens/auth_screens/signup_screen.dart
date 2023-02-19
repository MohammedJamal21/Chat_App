import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/auth/signup_form.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = '/signup';

  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final auth = FirebaseAuth.instance;

  bool isLoading = false;

  Future<void> _submitSignUpForm(
      String email, String password, String phoneNumber) async {
    UserCredential? userCredential;

    try {
      setState(() {
        isLoading = true;
      });
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((UserCredential userCredential2) {
        userCredential = userCredential2;
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential!.user!.uid)
          .set({
        'email': email,
        'phoneNumber': phoneNumber,
      });
      
      
    } on PlatformException catch (error) {
      String errorMessage = 'An error occurred, please check your credentials.';

      if (error.message != null) {
        errorMessage = error.message!;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      print(
          'XAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAALLLLLLLLLLLLLLLLLLLLLLLLLLLLAAAAAAAAAAAAAAAAAAAATTTTTTTTTTTTT');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Sign Up'),
              const SizedBox(
                height: 50,
              ),
              SignupForm(
                isLoading: isLoading,
                submit: _submitSignUpForm,
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
