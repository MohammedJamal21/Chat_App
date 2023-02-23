import 'package:chat_app/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  /*String? _idToken; //Token
  String? _email;
  String? _userId; // Local ID
  DateTime? _expiresIn;
  Timer? _authTimer;

  UserCredential? userCredential;
  */
  final firebaseAuth = FirebaseAuth.instance;

  Future signUp(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential != null) {
        String userId = userCredential.user!.uid;

        return userId;
        //DatabaseService().addUserDataToDatabase(userId, email, phoneNumber);
      }

      /*IdTokenResult idTokenResult =
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
      */
    } on FirebaseAuthException catch (error) {
      String errorMessage = 'An error occurred, please check your credentials.';

      if (error.message != null) {
        errorMessage = error.message!;
      }

      /*if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
        setState(() {
          isLoading = false;
        });
      }*/
    } catch (error) {
      rethrow;
      /*if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );

        setState(() {
          isLoading = false;
        });
      }*/
    }
  }
}
