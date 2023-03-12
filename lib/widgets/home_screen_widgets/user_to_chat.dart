// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/chatapp_user.dart';

class UserToChat extends StatefulWidget {
  final String userId;
  final String chatId;
  final NavigatorState navigatorState;

  const UserToChat({
    Key? key,
    required this.userId,
    required this.chatId,
    required this.navigatorState,
  }) : super(key: key);

  @override
  State<UserToChat> createState() => _UserToChatState();
}

class _UserToChatState extends State<UserToChat> {
  final DatabaseService databaseService = DatabaseService();
  String lastMessageText = '';
  DateTime lastMessageTime = DateTime(0, 0, 0, 0, 0);
  String lastMessageTimeInText = '';

  Future<String> showUsername(String userId) async {
    ChatAppUser user = await databaseService.findUserInDatabaseByUid(userId);

    return '${user.firstName} ${user.surname}';
  }

  @override
  Widget build(BuildContext context) {
    Widget? lastMessageAndTimeStreamBuilder(String lastMessage) {
      return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: databaseService.showLastMessageAndTime(widget.chatId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }
          if (snapshot.hasError) {
            return Container();
          }
          if (lastMessage == 'lastMessageText') {
            return Text(snapshot.data!.data()!['LastMessage'] ?? '');
          }
          if (lastMessage == 'lastMessageTime') {
            Timestamp timestamp =
                snapshot.data!.data()!['LastMessageTime'] ?? Timestamp(0, 0);
            DateTime dateTime = timestamp.toDate().toLocal();

            return Text(
              '${dateTime.hour}:${dateTime.minute}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            );
          }
          return const Text('');
        },
      );
    }

    return GestureDetector(
      onTap: () async {
        widget.navigatorState.pushNamed('/chat', arguments: {
          'userId': widget.userId,
          'chatId': widget.chatId,
          'userName': await showUsername(widget.userId),
        });
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 18,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FutureBuilder(
                  future: showUsername(widget.userId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text('');
                    }
                    if (!snapshot.hasData) {
                      return const Text('');
                    }
                    return Text(
                      snapshot.data!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
                lastMessageAndTimeStreamBuilder('lastMessageText')!,
              ],
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                lastMessageAndTimeStreamBuilder('lastMessageTime')!,
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
    /*Container(
      color: Colors.blueGrey,
      child: ListTile(
        onTap: () {
          Navigator.of(context).pushNamed('/chat');
        },
        leading: const CircleAvatar(),
        title: const Text('Hamudi@gmail.com'),
        subtitle: const Text('Last Message of Convo'),
        trailing: Column(
          children: const [
            Text('Last Message Time'),
            Text('Last Messaged that i have not see'),
          ],
        ),
      ),
    );*/
  }
}
