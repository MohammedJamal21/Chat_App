import 'package:flutter/material.dart';

class ChatAppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('efee'),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60);
}
