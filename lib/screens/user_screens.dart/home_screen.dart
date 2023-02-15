import 'package:chat_app/widgets/chat_app_appbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double statusBarHeight = mediaQueryData.padding.top;

    return Scaffold(
      appBar: ChatAppAppBar(
        statusBarHeight: statusBarHeight,
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Hello!'),
        ),
      ),
    );
  }
}
