import 'package:chat_app/providers/chatapp_user_provider.dart';
import 'package:chat_app/widgets/appbar/chat_app_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/database_service.dart';
import '../../widgets/home_screen_widgets/user_to_chat.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final databaseService = DatabaseService();

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
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double statusBarHeight = mediaQueryData.padding.top;
    NavigatorState navigatorState = Navigator.of(context);
    //final userId = Provider.of<ChatAppUserProvider>(context).getUser.userId;

    return Scaffold(
      appBar: ChatAppAppBar(
        parentNavigator: navigatorState,
        statusBarHeight: statusBarHeight,
      ),
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: databaseService.showUsersToChat(
              Provider.of<ChatAppUserProvider>(context, listen: false)
                  .getUser
                  .userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            return FutureBuilder(
                future: snapshot.data!.reference.get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  List<dynamic> userIdOfOtherUsers =
                      snapshot.data!.get('userIDOfOtherUsers');
                  List<dynamic> messageIdOfOtherUsers =
                      snapshot.data!.get('messageIdOfOtherUsers');

                  return ListView.builder(
                      itemCount: userIdOfOtherUsers.length,
                      itemBuilder: (context, index) {
                    return UserToChat(
                      userId: userIdOfOtherUsers[index],
                      chatId: messageIdOfOtherUsers[index],
                      navigatorState: Navigator.of(context),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

