import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/auth_service.dart';
import '../../services/database_service.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({
    super.key,
  });

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _form = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String phoneNumber = '';
  String firstName = '';
  String surname = '';
  bool isLoading = false;
  final authService = AuthService();
  final databaseService = DatabaseService();

  final _passwordController = TextEditingController();

  File? _image;
  final picker = ImagePicker();

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<String> uploadImageToFirebase() async {
    if (_image == null) {
      return "";
    }

    // Create a reference to the image file
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
    final firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);

    // Upload the image file to Firebase Storage
    final task = await firebaseStorageRef.putFile(_image!);
    final imageUrl = await task.ref.getDownloadURL();

    // Do something with the image URL, such as storing it in Firestore
    return imageUrl;
  }

  @override
  void dispose() {
    super.dispose();

    _passwordController.dispose();
  }

  Future<void> submitForm() async {
    setState(() {
      isLoading = true;
    });
    final bool isValid = _form.currentState!.validate();

    if (isValid) {
      _form.currentState!.save();

      await authService.signUp(email, password).then(
        (userCredential) async {
          String image = await uploadImageToFirebase();
          await databaseService.addNewUserDataToDatabase(
              userCredential!.user!.uid,
              email,
              phoneNumber,
              firstName,
              surname,
              image);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child:
                      _image != null ? const Text('') : const Text('No image'),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            elevation: const MaterialStatePropertyAll(
                              0,
                            ),
                            padding: const MaterialStatePropertyAll(
                                EdgeInsets.fromLTRB(15, 10, 15, 10))),
                        onPressed: () async {
                          await getImageFromCamera();
                        },
                        icon: const Icon(
                          Icons.camera,
                        ),
                        label: const Text('Take a picture'),
                      ),
                      ElevatedButton.icon(
                          style: ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              elevation: const MaterialStatePropertyAll(
                                0,
                              ),
                              padding: const MaterialStatePropertyAll(
                                  EdgeInsets.fromLTRB(15, 10, 15, 10))),
                          onPressed: () async {
                            await getImageFromGallery();
                          },
                          icon: const Icon(Icons.image_search_rounded),
                          label: const Text('Choose from gallery'))
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: TextFormField(
                onSaved: (newValue) {
                  firstName = newValue!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: "First name*",
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
                  surname = newValue!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your surname';
                  }
                  return null;
                },
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: "Surname*",
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
            isLoading == true
                ? const CircularProgressIndicator()
                : SizedBox(
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
                      onPressed: () async {
                        await submitForm();
                      },
                      child: const Text("Login"),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
