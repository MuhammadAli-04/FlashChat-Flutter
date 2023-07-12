import 'package:chat_app/Components/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/utilities/firebase_data.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {super.key, required this.name, required this.username, this.imgUrl});

  static String id = "ChatScreen";

  final String? imgUrl;
  final String name;
  final String username;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController msgController = TextEditingController();
  String? path;
  String username = FirebaseData().getCurrentUserData()!['username'];
  bool isLoaded = false;
  List<String> participants = [];

  @override
  void initState() {
    super.initState();

    participants = [username, widget.username];
    participants.sort();
    FirebaseFirestore.instance
        .collection('Chats')
        .where('participants', isEqualTo: participants)
        .get()
        .then(
      (value) {
        if (value.docs.isEmpty) {
          // print("in setchat()");
          setChat();
        }
        for (var doc in value.docs) {
          path = doc.data()['chat'];
          // print("chat already set");
          // print("path : $path");
        }
        setState(() {
          isLoaded = true;
        });
      },
    );
  }

  void setChat() async {
    path = DateTime.now().millisecondsSinceEpoch.toString();
    await FirebaseFirestore.instance.collection('Messages').doc(path!).set(
      {
        "messages": [
          {
            "sender": "System",
            "message": "Say Hi 👋 to ${widget.name} ",
            "time": DateTime.now().toString()
          }
        ]
      },
    );

    Map<String, dynamic> chat = {'participants': participants, 'chat': path};
    await FirebaseFirestore.instance.collection('Chats').add(chat);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: const AssetImage('images/user.jpg'),
              foregroundImage:
                  widget.imgUrl == null ? null : NetworkImage(widget.imgUrl!),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(widget.name),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
        elevation: 10.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: isLoaded
                  ? StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Messages')
                          .doc(path)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        var data = snapshot.data!.data()!['messages'] as List;
                        data = data.reversed.toList();
                        // for (var doc in snapshot.data.data()) {
                        //   print("snapshot");
                        //   data = doc.data();
                        // }
                        // print("snapshot data : $data");

                        return ListView.builder(
                          reverse: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            // print(data.length);
                            // print(data[index]);
                            return MessageBubble(
                              sender: data[index]['sender'],
                              text: data[index]['message'],
                              isMe: data[index]['sender'] == username
                                  ? true
                                  : false,
                            );
                          },
                        );
                      },
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
            TextField(
              controller: msgController,
              keyboardType: TextInputType.text,
              autocorrect: false,
              minLines: 1,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Message...",
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    if (msgController.text.isEmpty) {
                      return;
                    }
                    // print(path);

                    FirebaseFirestore.instance
                        .collection("Messages")
                        .doc(path!)
                        .update(
                      {
                        "messages": FieldValue.arrayUnion([
                          {
                            'sender': username,
                            'message': msgController.text,
                            'time': DateTime.now().toString()
                          }
                        ])
                      },
                    );
                    msgController.clear();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
