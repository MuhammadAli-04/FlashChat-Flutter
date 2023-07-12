import 'package:chat_app/Screens/chat_screen.dart';
import 'package:flutter/material.dart';

class SearchTile extends StatelessWidget {
  const SearchTile({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 20.0,
          backgroundImage: const AssetImage('images/user.jpg'),
          foregroundImage:
              data['imgPath'] != null ? NetworkImage(data['imgPath']) : null,
        ),
        title: Text(
          "${data['name']} (${data['username']})",
          style: const TextStyle(fontSize: 20.0),
        ),
        subtitle: Row(
          children: [
            OutlinedButton(
              onPressed: () {},
              child: const Text("View Profile"),
            ),
            const SizedBox(
              width: 5.0,
            ),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.blueAccent),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      name: data['name'],
                      username: data['username'],
                      imgUrl: data['imgPath'],
                    ),
                  ),
                );
              },
              child: const Text(
                "Message",
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
