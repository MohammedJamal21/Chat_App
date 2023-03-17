import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/chatapp_user_provider.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = '/settings';

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  /*@override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    String userId = FirebaseAuth.instance.currentUser!.uid;
    ChatAppUser chatAppUser =
        await DatabaseService().findUserInDatabaseByUid(userId);
    Provider.of<ChatAppUserProvider>(
      context,
      listen: false,
    ).setUser(chatAppUser);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Settings',
        ),
      ),
      body: Column(
        children: [
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
          ListTile(
            title: const Text('Edit Account'),
            tileColor: Colors.blue,
            trailing: IconButton(
                onPressed: () {}, icon: const Icon(Icons.arrow_forward)),
          ),
          ListTile(
            title: const Text('Change Password'),
            tileColor: Colors.blue,
            trailing: IconButton(
                onPressed: () {}, icon: const Icon(Icons.arrow_forward)),
          ),
          ListTile(
            title: const Text('Security & Privacy'),
            tileColor: Colors.blue,
            trailing: IconButton(
                onPressed: () {}, icon: const Icon(Icons.arrow_forward)),
          ),
          ListTile(
            title: const Text('Language'),
            tileColor: Colors.blue,
            trailing: IconButton(
                onPressed: () {}, icon: const Icon(Icons.arrow_forward)),
          ),
          SwitchListTile(
            title: const Text('App Notification'),
            tileColor: Colors.blue,
            value: false,
            onChanged: (value) {},
          ),
          SwitchListTile(
            title: const Text('Dark Theme'),
            tileColor: Colors.blue,
            value: false,
            onChanged: (value) {},
          ),
          const Spacer(),
          ElevatedButton(
              onPressed: () async {
                
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pop();
              },
              child: const Text('Log Out'))
        ],
      ),
    );
  }
}
