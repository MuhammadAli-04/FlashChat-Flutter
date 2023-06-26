import 'package:flutter/material.dart';
import '../Components/input_field.dart';
import '../Components/button.dart';
import '../utilities/validation.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  String? imgPath;

  String? validateReenteredPassword(String? value) {
    return value! == rePasswordController.text ? null : "Passwords donot match";
  }

  void showSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(value),
        action: SnackBarAction(
            label: 'Dismiss',
            onPressed: ScaffoldMessenger.of(context).removeCurrentSnackBar),
      ),
    );
  }

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
                  width: 50.0,
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
                    onPressed: () {
                      ImagePicker img = ImagePicker();
                      //TODO : implement image upload while registering
                    },
                    child: CircleAvatar(
                      radius: 64,
                      backgroundImage: const AssetImage('images/add-photo.jpg'),
                      foregroundImage:
                          imgPath != null ? AssetImage(imgPath!) : null,
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
                    validator: validateReenteredPassword,
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
                      try {
                        await auth.createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text);

                        final user = <String, dynamic>{
                          'name': fullNameController.text,
                          'email': emailController.text,
                          'username': usernameController.text
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
                                  "user created : ${doc.data()['username']}");
                            }
                          },
                        );

                        fullNameController.clear();
                        emailController.clear();
                        usernameController.clear();
                        passwordController.clear();
                        rePasswordController.clear();

                        Navigator.pop(context);
                      } catch (e) {
                        showSnackBar(e.toString());
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
