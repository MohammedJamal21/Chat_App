// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/services/database_service.dart';
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
  //late String username;

  Future<String> showUsername(String userId) async {
    ChatAppUser user = await databaseService.findUserInDatabaseByUid(userId);

    return user.email;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.navigatorState.pushNamed('/chat', arguments: {
          'userId': widget.userId,
          'chatId': widget.chatId,
        });
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 18,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
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
                    }),
                const Text(''),
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
