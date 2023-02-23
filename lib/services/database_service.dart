import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addUserDataToDatabase(
    String userId,
    String email,
    String phoneNumber,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).set(
        {
          'userId': userId,
          'email': email,
          'phoneNumber': phoneNumber,
        },
      );
    } catch (error) {
      rethrow;
    }
  }
}
