import 'package:chat_app/services/database_service.dart';
import 'package:flutter/material.dart';

import '../../models/chatapp_user.dart';

class ChatScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;

  const ChatScreenAppBar({Key? key, required this.userName}) : super(key: key);

  Future<String> showUsername(String userId) async {
    ChatAppUser user = await DatabaseService().findUserInDatabaseByUid(userId);

    return '${user.firstName} ${user.surname}';
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(  
      toolbarHeight: 70,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.videocam_outlined,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.call_outlined,
            ),
          ),
        ),
      ],
      leadingWidth: 250,
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back),
            ),
            const SizedBox(
              width: 10,
            ),
            const CircleAvatar(
              backgroundColor: Colors.black,
              radius: 16,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Online',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
