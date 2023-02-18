import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
          ElevatedButton(onPressed: () {}, child: const Text('Log Out'))
        ],
      ),
    );
  }
}
