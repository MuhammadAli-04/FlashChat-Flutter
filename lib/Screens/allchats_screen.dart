import 'package:flutter/material.dart';
import '../Components/chat_tile.dart';

class AllChatScreen extends StatefulWidget {
  const AllChatScreen({super.key});

  static const id = "AllChatScreen";

  @override
  State<AllChatScreen> createState() => _AllChatScreenState();
}

class _AllChatScreenState extends State<AllChatScreen> {
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
