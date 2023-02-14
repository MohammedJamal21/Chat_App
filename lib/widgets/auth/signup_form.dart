import 'package:flutter/material.dart';

class SignupForm extends StatefulWidget {
  final bool isLoading;
  final Function submit;

  const SignupForm({
    super.key,
    required this.isLoading,
    required this.submit,
  });

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _form = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String phoneNumber = '';

  final _passwordController = TextEditingController();

  void submitForm() {
    final bool isValid = _form.currentState!.validate();

    if (isValid) {
      _form.currentState!.save();
      widget.submit(email, password, phoneNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: SingleChildScrollView(
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
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: TextFormField(
                onSaved: (newValue) {
                  phoneNumber = newValue!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter a phone number';
                  }
                  if (!RegExp(
                          r'^(?:(?:\+|00)[1-9]\d{0,2}[\s-])?(?:[1-9]\d{0,2}[\s-])?\d{4,14}$')
                      .hasMatch(value)) {
                    return 'Enter a valid phone number';
                  }
                  return null;
                  
                },

                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Number*",
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
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value!.isEmpty || value.length < 8) {
                    return 'Password must be equal or more than 8 characters';
                  }
                  return null;
                },
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Create password",
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
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: TextFormField(
                onSaved: (newValue) {
                  password = newValue!;
                },
                validator: (value) {
                  if (value!.isEmpty || value.length < 8) {
                    return 'Password must be equal or more than 8 characters';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Confirm password",
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
            widget.isLoading
                ? const CircularProgressIndicator()
                :
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
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
            )
          ],
        ),
      ),
    );
  }
}
