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
      floatingActionButton: AddNewUserToChatButton(),
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
          builder: (context, snapshot1) {
            if (snapshot1.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot1.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            return FutureBuilder(
              future: snapshot1.data!.reference.get(),
              builder: (context, snapshot2) {
                if (snapshot2.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot2.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot2.hasError) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                List<dynamic> userIdOfOtherUsers =
                    snapshot2.data!.get('userIdOfOtherUsers');
                List<dynamic> messageIdOfOtherUsers =
                    snapshot2.data!.get('messageIdOfOtherUsers');

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

class AddNewUserToChatButton extends StatelessWidget {
  AddNewUserToChatButton({
    super.key,
  });
  final databaseService = DatabaseService();
  final emailController = TextEditingController();

  Future<void> addUserToChat(BuildContext context) async {
    if (emailController.text != '') {
      bool exists =
          await databaseService.checkIfUserExists(emailController.text);
      print(exists.toString());
      if (emailController.text !=
          Provider.of<ChatAppUserProvider>(context, listen: false)
              .getUser
              .email) {
        final userId =
            await databaseService.whatUserIdTheEmailUses(emailController.text);
        if ((await databaseService.checkIfUserIsInYourFriendList(
                Provider.of<ChatAppUserProvider>(context, listen: false)
                    .getUser
                    .userId,
                userId)) ==
            false) {
          await databaseService.addUserToChat(
              Provider.of<ChatAppUserProvider>(context, listen: false)
                  .getUser
                  .userId,
              userId);
          print('Done');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(
        Icons.message_outlined,
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Back'),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    await addUserToChat(context);
                  },
                  child: const Text("Add"),
                ),
              ],
              title: const Text("Enter the email address"),
              content: TextField(
                controller: emailController,
                /*onSaved: (newValue) {
                  email = newValue!;
                },
                validator: (value) {
                  if (!value!.contains('@') || value.isEmpty) {
                    return 'Email address is not valid';
                  }
                  return null;
                },*/
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email",
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 30,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
