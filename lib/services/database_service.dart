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

  Future<void> sendMessage(
      String chatId, String message, DateTime timestamp) async {
    await firebaseFirestore
        .collection('messages')
        .doc(chatId)
        .collection('userMessages')
        .add({
      'message': message,
      'timestamp': timestamp,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> chatStream(String chatId) {
    final collectionReference = firebaseFirestore
        .collection('messages')
        .doc(chatId)
        .collection('userMessages');

    final orderedQuery =
        collectionReference.orderBy('timestamp', descending: true);

    final orderedStream = orderedQuery.snapshots();

    return orderedStream;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> showUsersToChat(
      String userId) {
    DocumentReference<Map<String, dynamic>> documentReference =
        firebaseFirestore.collection('users').doc(userId);

    return documentReference.snapshots();
    // .map((event) => event.get('userIdOfOtherUsers') as List<String>);
  }

  Future<bool> checkIfUserExists(String email) async {
    final collectionReference = firebaseFirestore.collection('users');
    final querySnapshot =
        await collectionReference.where('email', isEqualTo: email).get();
    return querySnapshot.docs.isNotEmpty;
  }

  
}
