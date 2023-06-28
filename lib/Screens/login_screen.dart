import 'package:chat_app/Screens/chat_screen.dart';
import 'package:chat_app/utilities/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Components/button.dart';
import '../Components/input_field.dart';
import '../Components/heading.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../utilities/validation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const id = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final auth = FirebaseAuth.instance;
  final storage = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'logo',
                child: Image.asset(
                  'images/logo.png',
                  height: 150.0,
                ),
              ),
              const Heading(text: "Login "),
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputField(
                      controller: emailController,
                      keyboard: TextInputType.emailAddress,
                      hintText: "Email",
                      icon: Icons.email,
                      validator: Validation.validateEmail,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    InputField(
                      controller: passwordController,
                      keyboard: TextInputType.text,
                      hintText: "Password",
                      icon: Icons.password,
                      obscureData: true,
                      validator: Validation.validatePassword,
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    Button(
                      text: "Login",
                      onPressed: () async {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }

                        try {
                          await auth.signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text);
                          storage
                              .collection("Users")
                              .where('email', isEqualTo: emailController.text)
                              .get()
                              .then((value) {
                            for (var doc in value.docs) {
                              showSnackBar(
                                  "user logged in : ${doc.data()['username']}",
                                  context);
                            }
                          });
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              ChatScreen.id, (Route<dynamic> route) => false);
                        } catch (e) {
                          showSnackBar(e.toString(), context);
                        }

                        emailController.clear();
                        passwordController.clear();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
