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
        leading: CircleAvatar(
          backgroundImage: const AssetImage('images/add-photo.jpg'),
          foregroundImage: imgUrl != null ? NetworkImage(imgUrl!) : null,
          radius: 30.0,
        ),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
