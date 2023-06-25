import 'package:flutter/material.dart';

var kButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.resolveWith((states) =>
      states.contains(MaterialState.pressed)
          ? Colors.blueGrey
          : Colors.blueAccent),
  textStyle: MaterialStateProperty.resolveWith((states) => kButtonText),
);

const kButtonText = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w600,
  fontSize: 18.0,
);
