import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserMessageWidget extends StatelessWidget {
  final String messageText;
  final DateTime messageTime;
  final bool ownUser;

  UserMessageWidget(
      {super.key,
      required String message,
      required Timestamp time,
      required this.ownUser})
      : messageText = message,
        messageTime = time.toDate().toLocal();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          ownUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:
                ownUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ownUser ? Colors.blue.shade300 : Colors.blue.shade100,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20),
                    topRight: const Radius.circular(20),
                    bottomLeft: ownUser
                        ? const Radius.circular(20)
                        : const Radius.circular(0),
                    bottomRight: ownUser
                        ? const Radius.circular(0)
                        : const Radius.circular(20),
                  ),
                ),
                margin: ownUser
                    ? const EdgeInsets.fromLTRB(40, 0, 20, 5)
                    : const EdgeInsets.fromLTRB(20, 0, 40, 5),
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                child: Text(messageText),
              ),
              Container(
                margin: ownUser
                    ? const EdgeInsets.fromLTRB(0, 0, 20, 15)
                    : const EdgeInsets.fromLTRB(20, 0, 0, 15),
                child: Text(
                  '${messageTime.hour}:${messageTime.minute}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
