import 'package:chat_app/widgets/chat_app_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/chatapp_user.dart';
import '../../providers/chatapp_user_provider.dart';
import '../../services/database_service.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    String userId = FirebaseAuth.instance.currentUser!.uid;
    ChatAppUser chatAppUser =
        await DatabaseService().findUserInDatabaseByUid(userId);
    Provider.of<ChatAppUserProvider>(
      context,
      listen: false,
    ).setUser(chatAppUser);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double statusBarHeight = mediaQueryData.padding.top;
    NavigatorState navigatorState = Navigator.of(context);

    return Scaffold(
      appBar: ChatAppAppBar(
        parentNavigator: navigatorState,
        statusBarHeight: statusBarHeight,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              color: Colors.blueGrey,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed();
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
            ),
          ],
        ),
      ),
    );
  }
}
