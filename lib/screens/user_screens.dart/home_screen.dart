import 'package:chat_app/widgets/chat_app_appbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ChatAppAppBar(),
      body: Center(
        child: Text('Hello!'),
      ),
    );
  }
}
