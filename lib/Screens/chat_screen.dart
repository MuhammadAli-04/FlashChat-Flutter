import 'package:flutter/material.dart';
import '../Components/input_field.dart';

const messages = [
  {'ali': 'hello'},
];

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String name = "Ali";
  TextEditingController msgController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SafeArea(
          child: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              children: messages.map((value) => Text("$value")).toList(),
            ),
          ),
          InputField(
            controller: msgController,
            keyboard: TextInputType.text,
            // ignore: body_might_complete_normally_nullable
            validator: (value) {},
            hintText: "Message",
          )
        ],
      )),
    );
  }
}
