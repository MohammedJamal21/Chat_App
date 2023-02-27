import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserMessageWidget extends StatelessWidget {
  final String messageText;
  final DateTime messageTime;

  UserMessageWidget(
      {super.key, required String message, required Timestamp time})
      : messageText = message,
        messageTime = time.toDate().toLocal();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.zero,
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                margin: const EdgeInsets.fromLTRB(20, 20, 40, 0),
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),

                //width: min(a, b),
                child: Text(messageText),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                alignment: Alignment.topLeft,
                child: Text('${messageTime.hour}:${messageTime.minute}'),
              )
            ],
          ),
        ),
      ],
    );
  }
}
