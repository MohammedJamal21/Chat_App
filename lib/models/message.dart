import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String message;
  final Timestamp timestampOfMessage;

  Message(this.message, this.timestampOfMessage);
}
