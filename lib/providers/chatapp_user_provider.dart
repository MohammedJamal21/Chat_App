import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/chatapp_user.dart';

class ChatAppUserProvider extends ChangeNotifier {
  //String? _idToken; //Token
  //String? _email;
  //String? _userId; // Local ID
  //DateTime? _expiresIn;
  //Timer? _authTimer;
  ChatAppUser? chatAppUser;

  void setUser(ChatAppUser user) {
    chatAppUser = user;
    notifyListeners();
  }
}
