import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth extends ChangeNotifier {
  String? idToken; //Token
  String? email;
  String? userId; // Local ID
  DateTime? expiresIn;
  Timer? authTimer;

  UserCredential? userCredential;

  final auth = FirebaseAuth.instance;

  Future<void> signUp(String email, String password, String phoneNumber) async {
    userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    userId = userCredential!.user!.uid;
    IdTokenResult idTokenResult =
        await userCredential!.user!.getIdTokenResult();
    idToken = idTokenResult.token;
    expiresIn = idTokenResult.expirationTime;
    email = email;
    authTimer = Timer(
      Duration(
        seconds: expiresIn!
            .difference(
              DateTime.now(),
            )
            .inSeconds,
      ),
      () {},
    );
  }
}
