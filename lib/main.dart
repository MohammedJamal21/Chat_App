import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'screens/auth_screens/signup_screen.dart';
import 'screens/splash_screens/splash_screen.dart';
import 'screens/user_screens.dart/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  ChatApp({super.key});

  final Future<FirebaseApp> _initializeApp = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initializeApp,
        builder: (context, app) {
          return MaterialApp(
            title: 'Chat App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: app.connectionState == ConnectionState.waiting
                ? const SplashScreen()
                : StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SplashScreen();
                      }
                      if (!snapshot.hasData) {
                        return const SignupScreen();
                      }
                      return const HomeScreen();
                    },
                  ),
          );
        });
  }
}
