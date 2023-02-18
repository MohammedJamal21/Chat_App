import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
    required this.isLoading,
    required this.submit,
  }) : super(key: key);

  final bool isLoading;
  final Function submit;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _form = GlobalKey<FormState>();
  String email = '';
  String password = '';

  void submitForm() {
    final bool isValid = _form.currentState!.validate();

    if (isValid) {
      _form.currentState!.save();
      widget.submit(
        email,
        password,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: TextFormField(
              onSaved: (newValue) {
                email = newValue!;
              },
              validator: (value) {
                if (!value!.contains('@') || value.isEmpty) {
                  return 'Email address is not valid';
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email*",
                floatingLabelAlignment: FloatingLabelAlignment.start,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 30,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
              onSaved: (newValue) {
                password = newValue!;
              },
              validator: (value) {
                if (value!.isEmpty || value.length < 8) {
                  return 'Password must be equal or more than 8 characters';
                }
                return null;
              },
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password*",
                floatingLabelAlignment: FloatingLabelAlignment.start,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 30,
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: widget.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      submitForm();
                    },
                    child: const Text("Login"),
                  ),
          ),
        ],
      ),
    );
  }
}
