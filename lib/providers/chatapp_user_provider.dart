import 'package:flutter/material.dart';

import '../models/chatapp_user.dart';

class ChatAppUserProvider extends ChangeNotifier {
  //String? _idToken; //Token
  //String? _email;
  //String? _userId; // Local ID
  //DateTime? _expiresIn;
  //Timer? _authTimer;
  ChatAppUser _chatAppUser =
      ChatAppUser(userId: '', email: '', phoneNumber: '');

  void setUser(ChatAppUser user) {
    _chatAppUser = user;
    print('from Provider!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!ewffwfffwwffwff!!');
    notifyListeners();
  }

  ChatAppUser get getUser {
    return _chatAppUser;
  }
}
