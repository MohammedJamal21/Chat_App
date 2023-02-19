import 'package:chat_app/screens/auth_screens/login_screen.dart';
import 'package:chat_app/screens/auth_screens/signup_screen.dart';
import 'package:chat_app/screens/user_screens.dart/home_screen.dart';
import 'package:chat_app/screens/user_screens.dart/settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'screens/splash_screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ChatApp());
}

class ChatApp extends StatefulWidget {
  const ChatApp({super.key});

  @override
  State<ChatApp> createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> {
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
          home: (app.connectionState == ConnectionState.waiting)
              ? const SplashScreen()
              : StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.userChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SplashScreen();
                    }
                    if (!snapshot.hasData) {
                      return const LoginScreen();
                    }
                    return const SettingsScreen();
                  },
                ),
          routes: {
            SplashScreen.routeName: (context) {
              return const SplashScreen();
            },
            HomeScreen.routeName: (context) {
              return const HomeScreen();
            },
            SettingsScreen.routeName: (context) {
              return const SettingsScreen();
            },
            LoginScreen.routeName: (context) {
              return const LoginScreen();
            },
            SignupScreen.routeName: (context) {
              return const SignupScreen();
            }
          },
        );
      },
    );
  }
}
