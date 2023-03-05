import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/chatapp_user_provider.dart';
import '../../services/database_service.dart';

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
