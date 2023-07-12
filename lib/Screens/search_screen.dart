import 'package:flutter/material.dart';

import 'package:chat_app/Components/search_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/utilities/firebase_data.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<SearchTile> tiles = [];
  String search = "";
  FirebaseData firebaseData = FirebaseData();

  Future<List<SearchTile>> filterNames(String search) async {
    List<SearchTile> tiles = [];
    await FirebaseFirestore.instance.collection("Users").get().then((snapshot) {
      for (var doc in snapshot.docs) {
        var data = doc.data();
        if (data['username'].toString().contains(search.trim()) &&
            !data['username'].toString().contains(
                firebaseData.getCurrentUserData()!['username'].toString())) {
          tiles.add(
            SearchTile(
              data: data,
            ),
          );
        }
      }
    });
    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 32.0, 30.0, 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Text(
                "Search",
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            TextField(
              onChanged: (value) => setState(() {
                search = value;
              }),
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: "Enter username",
                prefixIcon: Icon(Icons.search),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: filterNames(search),
                builder: ((context, snapshot) {
                  if (ConnectionState.waiting == snapshot.connectionState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    tiles = snapshot.data!;
                  } else {
                    tiles = [];
                  }
                  return ListView(
                    children: tiles,
                  );
                }),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              child: const Text(
                "Done",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
