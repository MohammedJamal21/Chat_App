// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ChatAppAppBar extends StatelessWidget implements PreferredSizeWidget {
  double statusBarHeight;

  ChatAppAppBar({
    Key? key,
    required this.statusBarHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search,
          ),
        ),
        PopupMenuButton(
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
              const PopupMenuItem(
                child: Text('Settings'),
              ),
            ];
          },
        )
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        padding: EdgeInsets.fromLTRB(25, statusBarHeight, 20, 0),
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
              children: const [
                Text(
                  'Hey!',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Ahsan',
                  style: TextStyle(
                    fontSize: 14,
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
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(70);
}
