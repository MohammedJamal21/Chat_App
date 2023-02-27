import 'package:chat_app/services/database_service.dart';
import 'package:chat_app/widgets/chat_screen_widgets/user_message_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                  child: Container(
                color: Colors.blue,
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: null,
                  builder: (context, snapshot) {
                    return ListView(
                      children: const [
                        //-------------------------------------
                        UserMessageWidget(message: 'ifjeijf', time: 'efifeijfi'),
                        UserMessageWidget(message: 'ifjeijf', time: 'efifeijfi'),
                        UserMessageWidget(message: 'ifjeijf', time: 'efifeijfi'),
                        UserMessageWidget(message: 'ifjeijf', time: 'efifeijfi'),
                        UserMessageWidget(message: 'ifjeijf', time: 'efifeijfi'),
                        UserMessageWidget(message: 'ifjeijf', time: 'efifeijfi'),
                        //----------------------
                      ],
                    );
                  }
                ),
              )),
              //----------------------------------
              Container(
                width: MediaQuery.of(context).size.width - 20,
                color: Colors.yellow,
                child: TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Colors.lightBlue.shade100,
                    hintText: ' Message',
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (messageController.text != '') {
                          DatabaseService().sendMessage(
                              messageController.text, DateTime.now());
                          messageController.text = '';
                        }
                      },
                      icon: const Icon(
                        Icons.send_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
