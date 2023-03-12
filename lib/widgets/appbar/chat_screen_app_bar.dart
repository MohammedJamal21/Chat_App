import 'package:flutter/material.dart';


class ChatScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;

  const ChatScreenAppBar({Key? key, required this.userName}) : super(key: key);

  /*Future<String> showUsername(String userId) async {
    ChatAppUser user = await DatabaseService().findUserInDatabaseByUid(userId);

    return '${user.firstName} ${user.surname}';
  }*/

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
          preferredSize: preferredSize,
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
            ),
          )),
      elevation: 0,
      backgroundColor: Colors.white,
      toolbarHeight: 70,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.videocam_outlined,
            color: Colors.black,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.call_outlined,
              color: Colors.black,
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
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
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
              children: [
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  'Online',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
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
