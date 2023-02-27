// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/models/chatapp_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../providers/chatapp_user_provider.dart';
import '../../services/auth_service.dart';
import '../../services/database_service.dart';
import '../../widgets/auth_forms/login_form.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  final Function changeScreenToSignUp;

  const LoginScreen({
    Key? key,
    required this.changeScreenToSignUp,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService authService = AuthService();
  final DatabaseService databaseService = DatabaseService();
  ChatAppUser chatAppUser = ChatAppUser(userId: '', email: '', phoneNumber: '');
  ChatAppUserProvider? _chatAppUserProvider;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _chatAppUserProvider =
        Provider.of<ChatAppUserProvider>(context, listen: false);
  }

  Future<void> _submitLogInForm(
    String email,
    String password,
  ) async {
    try {
      setState(() {
        isLoading = true;
      });
      await authService.login(email, password).then((value) async {
        chatAppUser =
            await databaseService.findUserInDatabaseByUid(value!.user!.uid);
        //Provider.of<ChatAppUserProvider>(context, listen: false)
        //.setUser(chatAppUser);
        _chatAppUserProvider!.setUser(chatAppUser);
        print('uwhfeuhfuewhfuewhufhfwherrrerererererereerrerreruh');
      });
    } on PlatformException catch (error) {
      String errorMessage = 'An error occurred, please check your credentials.';

      if (error.message != null) {
        errorMessage = error.message!;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      print('eifjefijifjiejfjiefjiejfijeiEROOOOOOORRRR');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );

        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Login'),
              const SizedBox(
                height: 50,
              ),
              LoginForm(
                isLoading: isLoading,
                submit: _submitLogInForm,
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: () {
                      widget.changeScreenToSignUp();
                    },
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
