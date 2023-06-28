import 'package:chat_app/Screens/chat_screen.dart';
import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  ChatTile(
      {super.key, required this.title, required this.subtitle, this.imgUrl});

  final String title;
  final String subtitle;
  String? imgUrl;

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
                      ChatScreen(name: title, imgUrl: imgUrl)));
        },
        leading: CircleAvatar(
          backgroundImage: const AssetImage('images/user.jpg'),
          foregroundImage: imgUrl != null ? NetworkImage(imgUrl!) : null,
          radius: 30.0,
        ),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
