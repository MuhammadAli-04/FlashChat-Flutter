import 'package:flutter/material.dart';
import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

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
            padding: const EdgeInsets.all(32.0),
            child: Row(
              children: [
                Image.asset(
                  "images/logo.png",
                  width: 100.0,
                  height: 100.0,
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
            height: 100.0,
          ),
          TextButton(
            onPressed: () {},
            style: kButtonStyle,
            child: const Text(
              "Login",
              style: kButtonText,
            ),
          ),
          TextButton(
            onPressed: () {},
            onFocusChange: ((value) =>
                value ? Colors.blueAccent : Colors.lightBlue),
            style: TextButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              elevation: 5.0,
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 32.0,
              ),
              child: Text(
                "SignUp",
                style: kButtonText,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
