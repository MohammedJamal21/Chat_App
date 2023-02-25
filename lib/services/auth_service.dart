import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      return userCredential;

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
    return null;
  }

  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseAuthException {
      //--
    } catch (error) {
      //--
    }
  }

  Stream<User?> isSignedIn() {
    return firebaseAuth.authStateChanges();
  }
}
