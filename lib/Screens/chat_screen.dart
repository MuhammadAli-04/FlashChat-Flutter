import 'package:chat_app/Components/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, this.imgUrl, required this.name});

  static String id = "ChatScreen";
  final String? imgUrl;
  final String name;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController msgController = TextEditingController();

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
                child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('Chats').snapshots(),
              builder: (context, snapshot) => ListView(
                children: const [
                  MessageBubble(sender: "Ali", text: "Hey", isMe: true),
                  MessageBubble(
                      sender: "Hassan", text: "what's up?", isMe: false),
                  MessageBubble(
                      sender: "Hassan", text: "you good?", isMe: false),
                  MessageBubble(sender: "Ali", text: "Hey", isMe: true),
                ],
              ),
            )),
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
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
