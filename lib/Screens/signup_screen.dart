import 'dart:io';

import 'package:flutter/material.dart';
import '../Components/input_field.dart';
import '../Components/button.dart';
import '../utilities/validation.dart';
import '../utilities/constants.dart';
import '../Screens/chat_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  static const id = "SignupScreen";

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance.ref();

  String? imgPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            children: [
              Hero(
                tag: 'logo',
                child: Image.asset(
                  'images/logo.png',
                  width: 30.0,
                ),
              ),
              const Text("Registration Form")
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  MaterialButton(
                    onPressed: () async {
                      ImagePicker img = ImagePicker();
                      XFile? file =
                          await img.pickImage(source: ImageSource.gallery);
                      if (file != null) {
                        Reference imgDir =
                            storage.child("Images").child(file.name);
                        try {
                          imgDir
                              .putFile(File(file.path.toString()))
                              .snapshotEvents
                              .listen((snapshot) async {
                            switch (snapshot.state) {
                              case TaskState.success:
                                showSnackBar("Upload Successful", context);
                                String path = await imgDir.getDownloadURL();
                                setState(() {
                                  imgPath = path.toString();
                                });
                                break;
                              case TaskState.error:
                                showSnackBar(
                                    "Some error occurred,Please Try again!",
                                    context);
                                break;
                              default:
                                break;
                            }
                          });
                        } catch (e) {
                          showSnackBar(e.toString(), context);
                        }
                      }
                    },
                    child: CircleAvatar(
                      radius: 64,
                      backgroundImage: const AssetImage('images/add-photo.jpg'),
                      foregroundImage:
                          imgPath != null ? NetworkImage(imgPath!) : null,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  InputField(
                    controller: fullNameController,
                    keyboard: TextInputType.name,
                    validator: Validation.validateName,
                    hintText: "Your Name",
                    icon: Icons.badge,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  InputField(
                    controller: emailController,
                    keyboard: TextInputType.emailAddress,
                    validator: Validation.validateEmail,
                    hintText: "Email",
                    icon: Icons.email,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  InputField(
                    controller: usernameController,
                    keyboard: TextInputType.text,
                    validator: Validation.validateUsername,
                    hintText: "Username",
                    icon: Icons.email,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  InputField(
                    controller: passwordController,
                    keyboard: TextInputType.text,
                    validator: Validation.validatePassword,
                    hintText: "Password",
                    icon: Icons.password,
                    obscureData: true,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  InputField(
                    controller: rePasswordController,
                    keyboard: TextInputType.text,
                    validator: (value) {
                      return Validation.validateReenteredPassword(
                          value!, passwordController.text);
                    },
                    hintText: "Re-enter Password",
                    icon: Icons.password,
                    obscureData: true,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Button(
                    text: "Register",
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      try {
                        await auth.createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text);

                        final user = <String, dynamic>{
                          'name': fullNameController.text,
                          'email': emailController.text,
                          'username': usernameController.text,
                          'imgPath': imgPath
                        };

                        db.collection('Users').add(user);

                        await db
                            .collection('Users')
                            .where('email', isEqualTo: auth.currentUser!.email)
                            .get()
                            .then(
                          (value) {
                            for (var doc in value.docs) {
                              showSnackBar(
                                  "user created : ${doc.data()['username']}",
                                  context);
                            }
                          },
                        );

                        fullNameController.clear();
                        emailController.clear();
                        usernameController.clear();
                        passwordController.clear();
                        rePasswordController.clear();

                        Navigator.of(context).pushNamedAndRemoveUntil(
                            ChatScreen.id, (Route<dynamic> route) => false);
                      } catch (e) {
                        showSnackBar(e.toString(), context);
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
