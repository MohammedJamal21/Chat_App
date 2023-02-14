import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'screens/auth_screens/signup_screen.dart';
import 'screens/splash_screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  ChatApp({super.key});

  final Future<FirebaseApp> _initializeApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initializeApp,
        builder: (context, app) {
          if (app.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }
          return MaterialApp(
            title: 'Chat App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const SignupScreen(),
          );
        });
  }
}
