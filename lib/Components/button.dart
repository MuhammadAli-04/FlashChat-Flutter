import 'package:flutter/material.dart';
import 'package:chat_app/utilities/constants.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.text, required this.onPressed});

  final String text;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: Colors.blueAccent,
          elevation: 5.0,
          fixedSize: const Size(200.0, 50.0),
        ),
        child: Text(
          text,
          style: kButtonText,
        ),
      ),
    );
  }
}
