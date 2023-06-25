import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';

class Heading extends StatelessWidget {
  const Heading({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Text(
        text,
        style: kHeadingStyle,
      ),
    );
  }
}
