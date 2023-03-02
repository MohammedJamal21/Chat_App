import 'package:chat_app/screens/auth_screens/login_screen.dart';
import 'package:chat_app/screens/auth_screens/signup_screen.dart';
import 'package:chat_app/screens/user_screens/home_screen.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/chatapp_user.dart';
import '../../providers/chatapp_user_provider.dart';
import '../../services/database_service.dart';
import '../splash_screens/splash_screen.dart';

class HandlerScreen extends StatelessWidget {
  static const routeName = '/handler';

  const HandlerScreen({Key? key}) : super(key: key);

  Future<void> assignChatAppUserToProvider(BuildContext context) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    ChatAppUser chatAppUser =
        await DatabaseService().findUserInDatabaseByUid(userId);
    Provider.of<ChatAppUserProvider>(
      context,
      listen: false,
    ).setUser(chatAppUser);
  }

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

        return FutureBuilder(
          future: assignChatAppUserToProvider(context),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            }
            /*if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }*/
            
            return const HomeScreen();
          },
        );
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
