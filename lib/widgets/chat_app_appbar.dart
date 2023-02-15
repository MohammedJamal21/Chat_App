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
    print(statusBarHeight);
    return AppBar(
      
      flexibleSpace: Container(
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        padding: EdgeInsets.fromLTRB(10, statusBarHeight, 10, 0),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.black,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Hey!'),
                Text('Ahsan'),
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
