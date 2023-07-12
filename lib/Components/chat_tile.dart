import 'package:chat_app/Screens/chat_screen.dart';
import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  const ChatTile(
      {super.key,
      required this.name,
      required this.message,
      required this.username,
      this.imgUrl});

  final String name;
  final String message;
  final String? imgUrl;
  final String username;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ChatScreen(name: name, username: username, imgUrl: imgUrl),
            ),
          );
        },
        leading: CircleAvatar(
          backgroundImage: const AssetImage('images/user.jpg'),
          foregroundImage: imgUrl != null ? NetworkImage(imgUrl!) : null,
          radius: 30.0,
        ),
        title: Text(name),
        subtitle: Text(message),
      ),
    );
  }
}
