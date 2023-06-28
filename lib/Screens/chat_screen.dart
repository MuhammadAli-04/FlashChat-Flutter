import 'package:flutter/material.dart';
import '../Components/chat_tile.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static const id = "ChatScreen";

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String name = "Ali";
  TextEditingController msgController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.blueGrey,
        child: SafeArea(
          child: Column(
            children: [
              DrawerHeader(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    const Text(
                      "Drawer Header",
                      style: TextStyle(fontSize: 20),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
              ),
              const Text("Hello"),
              const Text("Hello"),
              const Text("Hello"),
              const Text("Hello"),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Chats"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
          )
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          children: [
            ChatTile(
              title: "Ali",
              subtitle: "Hello",
            ),
            ChatTile(
              title: "Ali",
              subtitle: "Hello",
            ),
            ChatTile(
              title: "Ali",
              subtitle: "Hello",
            ),
            ChatTile(
              title: "Ali",
              subtitle: "Hello",
            ),
            ChatTile(
              title: "Ali",
              subtitle: "Hello",
            ),
            ChatTile(
              title: "Ali",
              subtitle: "Hello",
            ),
            ChatTile(
              title: "Ali",
              subtitle: "Hello",
            ),
            ChatTile(
              title: "Ali",
              subtitle: "Hello",
            ),
            ChatTile(
              title: "Ali",
              subtitle: "Hello",
            ),
            ChatTile(
              title: "Ali",
              subtitle: "Hello",
            ),
            ChatTile(
              title: "Ali",
              subtitle: "Hello",
            ),
            ChatTile(
              title: "Ali",
              subtitle: "Hello",
            ),
            ChatTile(
              title: "Ali",
              subtitle: "Hello",
            ),
            ChatTile(
              title: "Ali",
              subtitle: "Hello",
            ),
            ChatTile(
              title: "Ali",
              subtitle: "Hello",
            ),
          ],
        ),
      ),
    );
  }
}
