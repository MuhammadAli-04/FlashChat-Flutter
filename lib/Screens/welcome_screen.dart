import 'package:chat_app/Screens/login_screen.dart';
import 'package:chat_app/Screens/signup_screen.dart';
import 'package:flutter/material.dart';
import '../Components/button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  static String id = "WelcomeScreen";

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Flash Chat"),
        ),
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Row(
              children: [
                Hero(
                  tag: "logo",
                  child: Image.asset(
                    "images/logo.png",
                    height: 50.0,
                  ),
                ),
                const Text(
                  "Flash Chat",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50.0,
          ),
          Button(
            onPressed: () {
              Navigator.pushNamed(context, LoginScreen.id);
            },
            text: "Login",
          ),
          Button(
            onPressed: () {
              Navigator.pushNamed(context, SignupScreen.id);
            },
            text: "Signup",
          ),
        ],
      )),
    );
  }
}
