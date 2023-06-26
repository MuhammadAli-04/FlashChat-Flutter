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

const kOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
);

var kInputDecoration = InputDecoration(
  enabledBorder: kOutlineInputBorder.copyWith(
    borderSide: const BorderSide(color: Colors.lightBlue),
  ),
  focusedBorder: kOutlineInputBorder.copyWith(
    borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
  ),
  disabledBorder: kOutlineInputBorder.copyWith(
    borderSide: const BorderSide(color: Colors.blueGrey),
  ),
  errorBorder: kOutlineInputBorder.copyWith(
      borderSide: const BorderSide(color: Colors.red, width: 2.0)),
  focusedErrorBorder: kOutlineInputBorder.copyWith(
      borderSide: const BorderSide(color: Colors.red, width: 2.0)),
);

const kHeadingStyle = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    letterSpacing: 2.0,
    color: Colors.blueAccent,
    decoration: TextDecoration.underline);
