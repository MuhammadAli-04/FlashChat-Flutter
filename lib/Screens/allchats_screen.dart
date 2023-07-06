import 'package:flutter/material.dart';
import 'search_screen.dart';
import 'package:chat_app/Components/chat_tile.dart';
import 'package:chat_app/Components/app_drawer.dart';
import 'package:chat_app/utilities/firebase_data.dart';

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
  void initState() {
    super.initState();
    FirebaseData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
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
          children: const [],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => const SearchScreen(),
          );
        },
        child: const Icon(Icons.add_comment),
      ),
    );
  }
}
