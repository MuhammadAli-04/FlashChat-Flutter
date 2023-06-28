import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key, this.imgUrl, required this.name});

  static String id = "ChatScreen";
  String? imgUrl;
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
            const SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Text("Hello"),
                    Text("Hello"),
                    Text("Hello"),
                    Text("Hello"),
                    Text("Hello"),
                    Text("Hello"),
                    Text("Hello"),
                    Text("Hello"),
                    Text("Hello"),
                    Text("Hello"),
                    Text("Hello"),
                    Text("Hello"),
                    Text("Hello"),
                    Text("Hello"),
                    Text("Hello"),
                    Text("Hello"),
                    Text("Hello"),
                    Text("Hello"),
                    Text("Hello"),
                    Text("Hello"),
                  ],
                )),
            TextField(
              controller: msgController,
              keyboardType: TextInputType.text,
              autocorrect: false,
              minLines: 1,
              maxLines: 3,
              decoration: const InputDecoration(
                  hintText: "Message...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
