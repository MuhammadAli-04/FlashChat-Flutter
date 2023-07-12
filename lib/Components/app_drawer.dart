import 'package:chat_app/Screens/welcome_screen.dart';
import 'package:chat_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/utilities/firebase_data.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({super.key});

  final firebaseData = FirebaseData();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blueGrey,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 32.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DrawerHeader(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      firebaseData.getCurrentUserData()!['name'].toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              const Column(
                children: [
                  Text("Hello"),
                  Text("Hello"),
                  Text("Hello"),
                  Text("Hello"),
                ],
              ),
              TextButton(
                onPressed: () async {
                  bool isSignedOut = await firebaseData.signOut((value) {
                    showSnackBar(value, context);
                  });
                  isSignedOut
                      ? Navigator.pushNamedAndRemoveUntil(
                          context, WelcomeScreen.id, (route) => false)
                      : null;
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                child: const Text(
                  "LogOut",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
