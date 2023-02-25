// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/models/chatapp_user.dart';
import 'package:chat_app/providers/chatapp_user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../widgets/auth/login_form.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  final Function changeScreenToSignUp;

  const LoginScreen({
    Key? key,
    required this.changeScreenToSignUp,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final auth = FirebaseAuth.instance;

  bool isLoading = false;

  Future<void> _submitLogInForm(
    String email,
    String password,
  ) async {
    try {
      setState(() {
        isLoading = true;
      });
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Provider.of<ChatAppUserProvider>(context).setUser(
          ChatAppUser(userId: userId, email: email, phoneNumber: phoneNumber)
        );
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
              const Text('Login'),
              const SizedBox(
                height: 50,
              ),
              LoginForm(
                isLoading: isLoading,
                submit: _submitLogInForm,
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: () {
                      widget.changeScreenToSignUp();
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
