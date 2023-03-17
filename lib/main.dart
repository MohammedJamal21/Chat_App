import 'package:chat_app/providers/chatapp_user_provider.dart';
import 'package:chat_app/screens/auth_screens/handler_screen.dart';
import 'package:chat_app/screens/user_screens/home_screen.dart';
import 'package:chat_app/screens/user_screens/settings_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'screens/splash_screens/splash_screen.dart';
import 'screens/user_screens/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  /*FirebaseCoreWeb.registerService('auth', (app) {
    return () async {
      return FirebaseAuth.instance;
    };
  });*/

  runApp(const ChatApp());
}

class ChatApp extends StatefulWidget {
  const ChatApp({super.key});

  @override
  State<ChatApp> createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            return ChatAppUserProvider();
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HandlerScreen(),
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
          HandlerScreen.routeName: (context) {
            return const HandlerScreen();
          },
          ChatScreen.routeName: (context) {
            return const ChatScreen();
          },
          /*LoginScreen.routeName: (context) {
            return const LoginScreen();
          },
          SignupScreen.routeName: (context) {
            return const SignupScreen();
          },*/
        },
      ),
    );
  }
}
