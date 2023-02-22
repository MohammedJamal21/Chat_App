import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Auth extends ChangeNotifier {
  String? _idToken; //Token
  String? _email;
  String? _userId; // Local ID
  DateTime? _expiresIn;
  Timer? _authTimer;

  UserCredential? userCredential;

  final auth = FirebaseAuth.instance;

  Future<void> signUp(String email, String password, String phoneNumber) async {
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      _userId = userCredential!.user!.uid;

      IdTokenResult idTokenResult =
          await userCredential!.user!.getIdTokenResult();

      _idToken = idTokenResult.token;
      _expiresIn = idTokenResult.expirationTime;
      _email = email;
      _authTimer = Timer(
        Duration(
          seconds: _expiresIn!
              .difference(
                DateTime.now(),
              )
              .inSeconds,
        ),
        () {},
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential!.user!.uid)
          .set(
        {
          'email': email,
          'phoneNumber': phoneNumber,
        },
      );
    } on PlatformException catch (error) {
      String errorMessage = 'An error occurred, please check your credentials.';

      if (error.message != null) {
        errorMessage = error.message!;
      }

      throw errorMessage;
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      throw error;
      if (mounted) {
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
  }
}
