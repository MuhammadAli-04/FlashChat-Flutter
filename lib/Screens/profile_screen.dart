import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundImage: const AssetImage('images/user.jpg'),
            foregroundImage: widget.data['imgPath'] != null
                ? NetworkImage(widget.data['imgPath'])
                : null,
          ),
          Text(widget.data['name']),
          Text(widget.data['username']),
          Text(widget.data['bio']),
        ],
      )),
    );
  }
}
