import 'package:flutter/material.dart';

import 'package:chat_app/Components/button.dart';
import 'package:chat_app/Components/input_field.dart';
import 'package:chat_app/Components/heading.dart';
import 'package:chat_app/Screens/allchats_screen.dart';
import 'package:chat_app/utilities/constants.dart';
import 'package:chat_app/utilities/validation.dart';

import 'package:chat_app/utilities/firebase_data.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const id = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FirebaseData firebaseData = FirebaseData();

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
                key: _formKey,
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
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }

                        bool isSignedIn = await firebaseData.signinUser(
                            emailController.text,
                            passwordController.text,
                            (value) => showSnackBar(value, context));

                        if (isSignedIn) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              AllChatScreen.id,
                              (Route<dynamic> route) => false);
                          _formKey.currentState!.reset();
                        }
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
