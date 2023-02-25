// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/providers/chatapp_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatAppAppBar extends StatelessWidget implements PreferredSizeWidget {
  double statusBarHeight;

  ChatAppAppBar({
    Key? key,
    required this.statusBarHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 70,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: PopupMenuButton(
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.menu,
            ),
            position: PopupMenuPosition.under,
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  child: Text('New Group'),
                ),
                const PopupMenuItem(
                  child: Text('New Broadcast'),
                ),
                const PopupMenuItem(
                  child: Text('Linked Devices'),
                ),
                const PopupMenuItem(
                  child: Text('Stored Messages'),
                ),
                const PopupMenuItem(
                  child: Text('Archived Messages'),
                ),
                PopupMenuItem(
                  child: const Text('Settings'),
                  onTap: () {
                    Navigator.of(context).pushNamed('/settings');
                  },
                ),
              ];
            },
          ),
        ),
      ],
      leadingWidth: 250,
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: Row(
          children: [
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
              children: [
                const Text(
                  'Hey!',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Consumer<ChatAppUserProvider>(
                  builder: (ctx, user, _) {
                    String email = user.getUser.email;

                    return Text(
                      email,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(70);
}
