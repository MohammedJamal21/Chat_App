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

  Future<void> sendMessage(String message, DateTime timestamp) async {
    await firebaseFirestore.collection('messages').add({
      'message': message,
      'timestamp': timestamp,
    });
  }

  /*Stream<QuerySnapshot<Map<String, dynamic>>> messageStream() {
    
    Without a specific user preference to know which other users to message

    final collectionReference = firebaseFirestore.collection('messages');

    final orderedQuery =
        collectionReference.orderBy('timestamp', descending: true);

    final orderedStream = orderedQuery.snapshots();

    return orderedStream;
  }*/

  Stream<DocumentSnapshot<Map<String, dynamic>>> showUsersToChat(
      String userId) {
    DocumentReference<Map<String, dynamic>> documentReference =
        firebaseFirestore.collection('users').doc(userId);

    return documentReference.snapshots();
    // .map((event) => event.get('userIdOfOtherUsers') as List<String>);
  }
}
