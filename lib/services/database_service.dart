import 'package:chat_app/models/chatapp_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addNewUserDataToDatabase(
    String userId,
    String email,
    String phoneNumber,
  ) async {
    try {
      await firebaseFirestore.collection('users').doc(userId).set(
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

  Future<ChatAppUser> findUserInDatabaseByUid(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> userData =
        await firebaseFirestore.collection('users').doc(uid).get();

    final user = userData.data()!;

    final userId = user['userId'];
    final email = user['email'];
    final phoneNumber = user['phoneNumber'];

    print(userId + email + phoneNumber);
    return ChatAppUser(userId: userId, email: email, phoneNumber: phoneNumber);
  }
}
