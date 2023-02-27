import 'package:chat_app/widgets/chat_screen_widgets/user_message_widget.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = '/chat';

  const ChatScreen({Key? key}) : super(key: key);

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
                child: ListView(
                  children: const [
                    //-------------------------------------
                    UserMessageWidget(message: 'ifjeijf', time: 'efifeijfi')
                    //----------------------
                  ],
                ),
              )),
              //----------------------------------
              Container(
                width: MediaQuery.of(context).size.width - 20,
                color: Colors.yellow,
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none),
                      filled: true,
                    fillColor: Colors.lightBlue.shade100,
                      hintText: ' Message',
                      suffixIcon: IconButton(
                          onPressed: () {},
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

