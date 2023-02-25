import 'package:chat_app/screens/auth_screens/login_screen.dart';
import 'package:chat_app/screens/auth_screens/signup_screen.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../splash_screens/splash_screen.dart';
import '../user_screens.dart/settings_screen.dart';

class HandlerScreen extends StatelessWidget {
  const HandlerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().isSignedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }
        if (!snapshot.hasData) {
          return const AuthHandler();
        }
        return const SettingsScreen();
      },
    );
  }
}

class AuthHandler extends StatefulWidget {
  const AuthHandler({Key? key}) : super(key: key);

  @override
  State<AuthHandler> createState() => _AuthHandlerState();
}

class _AuthHandlerState extends State<AuthHandler> {
  bool isLoginPage = true;

  void changeScreen() {
    setState(() {
      isLoginPage = !isLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoginPage) {
      return LoginScreen(
        changeScreenToSignUp: changeScreen,
      );
    } else {
      return SignupScreen(
        changeScreenToLogin: changeScreen,
      );
    }
  }
}
