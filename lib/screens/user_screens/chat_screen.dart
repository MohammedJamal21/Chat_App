import 'package:chat_app/services/database_service.dart';
import 'package:chat_app/widgets/chat_screen_widgets/user_message_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../widgets/appbar/chat_screen_app_bar.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  final databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    return Scaffold(
      appBar: const ChatScreenAppBar(),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Colors.blue,
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: databaseService.chatStream(arg['chatId']!),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      } else {
                        return ListView.builder(
                          reverse: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.hasError) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            final timestamp = snapshot.data!.docs[index]
                                ['timestamp'] as Timestamp?;
                            final estimatedTimestamp =
                                timestamp ?? Timestamp.now();

                            return UserMessageWidget(
                                ownUser: (snapshot.data!.docs[index]
                                        ['userId'] ==
                                    arg['userId']!),
                                message: snapshot.data!.docs[index]['message'],
                                time: estimatedTimestamp);
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
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
                          databaseService.sendMessage(arg['chatId']!,
                              arg['userId']!, messageController.text);
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
