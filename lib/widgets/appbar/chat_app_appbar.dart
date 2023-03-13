// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/providers/chatapp_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatAppAppBar extends StatefulWidget implements PreferredSizeWidget {
  double statusBarHeight;
  NavigatorState parentNavigator;

  ChatAppAppBar({
    Key? key,
    required this.statusBarHeight,
    required this.parentNavigator,
  }) : super(key: key);

  @override
  State<ChatAppAppBar> createState() => _ChatAppAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(70);
}

class _ChatAppAppBarState extends State<ChatAppAppBar> {
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
            color: Colors.white.withOpacity(0.80),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onSelected: (value) {
              if (value == 'settings') {
                widget.parentNavigator.pushNamed('/settings');
              }
            },
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.menu,
            ),
            position: PopupMenuPosition.under,
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  child: Text(
                    'New Group',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const PopupMenuItem(
                  child: Text(
                    'New Broadcast',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const PopupMenuItem(
                  child: Text(
                    'Linked Devices',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const PopupMenuItem(
                  child: Text(
                    'Stored Messages',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const PopupMenuItem(
                  child: Text(
                    'Archived Messages',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const PopupMenuItem(
                  value: 'settings',
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                    String firstName = user.getUser.firstName;

                    return Text(
                      firstName,
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
}
