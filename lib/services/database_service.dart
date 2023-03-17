import 'dart:io';

import 'package:chat_app/models/chatapp_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  final firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addNewUserDataToDatabase(
    String userId,
    String email,
    String phoneNumber,
    String firstName,
    String surname,
    File? image,
  ) async {
    try {
      String imageUrl = await uploadImageToFirebase(image!);

      await firebaseFirestore.collection('users').doc(userId).set(
        {
          'userId': userId,
          'email': email,
          'phoneNumber': phoneNumber,
          'firstName': firstName,
          'surname': surname,
          'messageIdOfOtherUsers': [],
          'userIdOfOtherUsers': [],
          'imageUrl': imageUrl,
        },
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<String> uploadImageToFirebase(File image) async {
    if (image == null) {
      print(
          'ijifjfjijfiHELLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLjie1');
      return "";
    }
    print('HALLLLLAAAAAAWWWWW!!!!!!!!!!!!!!2');
    // Create a reference to the image file

    final Reference firebaseStorageRef = FirebaseStorage.instance.ref();

    print('XXXXXXXXXXXXXXXXXXOOOOOOOOOOOOOOOOOOOOOOOMMMMMMMMMMMMMMMMMMMM1');

    final Reference referenceOfUsersImages =
        firebaseStorageRef.child('profilePictures');
    //.child(fileName);

    print('XXXXXXXXXXXXXXXXXXOOOOOOOOOOOOOOOOOOOOOOOMMMMMMMMMMMMMMMMMMMM2');

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    print('XXXXXXXXXXXXXXXXXXOOOOOOOOOOOOOOOOOOOOOOOMMMMMMMMMMMMMMMMMMMM3');

    final Reference referenceOfUserImage =
        referenceOfUsersImages.child(uniqueFileName);
    //final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';

    print('HALLLLLAAAAAAWWWWW!!!!!!!!!!!!!!3');
    // Upload the image file to Firebase Storage

    try {
      print('XXXXXXXXXXXXXXXXXXOOOOOOOOOOOOOOOOOOOOOOOMMMMMMMMMMMMMMMMMMMM4');

      await referenceOfUserImage.putFile(image);

      String urlImage = '';

      print('XXXXXXXXXXXXXXXXXXOOOOOOOOOOOOOOOOOOOOOOOMMMMMMMMMMMMMMMMMMMM5');

      urlImage = await referenceOfUserImage.getDownloadURL();

      print('XXXXXXXXXXXXXXXXXXOOOOOOOOOOOOOOOOOOOOOOOMMMMMMMMMMMMMMMMMMMM6');

      //String url = await referenceOfUserImage.getDownloadURL();

      return urlImage;
    } catch (err) {
      print(
          '1111111111111111111111122222222222222222222222233333333333333333333333333444444444444455555555555555');
      print(err);
      return '';
    }
  }

  Future<ChatAppUser> findUserInDatabaseByUid(String uid) async {
    bool dataAvailable = false;

    DocumentSnapshot<Map<String, dynamic>>? userData;

    while (!dataAvailable) {
      userData = await firebaseFirestore.collection('users').doc(uid).get();
      dataAvailable = userData.exists;
      if (!dataAvailable) {
        // Wait for 1 second before retrying
        await Future.delayed(const Duration(seconds: 2));
      }
    }

    final user = userData!.data()!;

    final userId = user['userId'];
    final email = user['email'];
    final phoneNumber = user['phoneNumber'];
    final firstName = user['firstName'];
    final surname = user['surname'];
    final imageUrl = user['imageUrl'];

    print(userId + email + phoneNumber);
    return ChatAppUser(
      userId: userId,
      email: email,
      phoneNumber: phoneNumber,
      firstName: firstName,
      surname: surname,
      imageUrl: imageUrl,
    );
  }

  Future<void> sendMessage(String chatId, String userId, String message) async {
    final timeValue = FieldValue.serverTimestamp();

    await firebaseFirestore
        .collection('messages')
        .doc(chatId)
        .collection('userMessages')
        .add({
      'message': message,
      'timestamp': timeValue,
      'userId': userId,
    });

    await firebaseFirestore.collection('messages').doc(chatId).update({
      'LastMessage': message,
      'LastMessageTime': timeValue,
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

  Stream<DocumentSnapshot<Map<String, dynamic>>> showLastMessageAndTime(
      String chatId) {
    final collectionReference =
        firebaseFirestore.collection('messages').doc(chatId);

    return collectionReference.snapshots();
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

  Future<bool> checkIfUserIsInYourFriendList(
      String userId, String friendUserId) async {
    final documentReference = firebaseFirestore.collection('users').doc(userId);

    final documentSnapshot = await documentReference.get();

    List<dynamic> userIdOfOtherUsers =
        documentSnapshot.get('userIdOfOtherUsers');

    return userIdOfOtherUsers.contains(friendUserId);
  }

  Future<String> whatUserIdTheEmailUses(String email) async {
    final collectionReference = firebaseFirestore.collection('users');
    final querySnapshot =
        await collectionReference.where('email', isEqualTo: email).get();
    final document = querySnapshot.docs.first;
    return document.get('userId') as String;
  }

  Future<void> addUserToChat(String userId, String newFriendUserId) async {
    final documentReference = firebaseFirestore.collection('users').doc(userId);
    final friendDocumentReference =
        firebaseFirestore.collection('users').doc(newFriendUserId);

    final userMessagesReference =
        await firebaseFirestore.collection('messages').add({
      'LastMessage': '',
      'LastMessageTime': '',
    });

    final collectionReference =
        userMessagesReference.collection('userMessages');

    documentReference.update(
      {
        'userIdOfOtherUsers': FieldValue.arrayUnion([newFriendUserId]),
        'messageIdOfOtherUsers':
            FieldValue.arrayUnion([userMessagesReference.id]),
      },
    );

    friendDocumentReference.update({
      'userIdOfOtherUsers': FieldValue.arrayUnion([userId]),
      'messageIdOfOtherUsers':
          FieldValue.arrayUnion([userMessagesReference.id]),
    });
  }
}
