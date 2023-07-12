import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'search_screen.dart';
import 'package:chat_app/Components/chat_tile.dart';
import 'package:chat_app/Components/app_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:chat_app/utilities/firebase_data.dart';

class AllChatScreen extends StatefulWidget {
  const AllChatScreen({super.key});

  static const id = "AllChatScreen";

  @override
  State<AllChatScreen> createState() => _AllChatScreenState();
}

class _AllChatScreenState extends State<AllChatScreen> {
  var firebaseData = FirebaseData();
  TextEditingController msgController = TextEditingController();
  String username = "";
  String? imgUrl;
  bool isLoaded = false;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('Users')
        .where("email", isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) {
      for (var doc in value.docs) {
        username = doc.data()['username'];
      }
      setState(() {
        isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
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
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              child: !isLoaded
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Chats')
                          .where('participants', arrayContains: username)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        var data = snapshot.data!.docs
                            .map((e) => e.data()['participants']);
                        var list = data.map((e) {
                          for (var i in e) {
                            if (i.toString() != username) {
                              return i;
                            }
                          }
                        }).toList();
                        return ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> data = firebaseData
                                  .getUsersData()
                                  .where((element) =>
                                      element['username'] == list[index]!)
                                  .first;

                              return ChatTile(
                                name: data['name'],
                                message: "Hello",
                                username: data['username'],
                                imgUrl: data['imgPath'],
                              );
                            });
                      },
                    ),
            ),
          ],
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
