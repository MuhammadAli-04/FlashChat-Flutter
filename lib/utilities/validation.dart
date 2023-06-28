import 'package:email_validator/email_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'constants.dart';

class Validation {
  static String? validateName(String? value) => value!.isEmpty
      ? "Enter name"
      : value.contains(RegExp(r'[0-9]'))
          ? "Invalid name"
          : null;

  static String? validateEmail(String? value) => value!.isEmpty
      ? "Enter e-mail"
      : EmailValidator.validate(value)
          ? null
          : "Enter valid e-mail";

  static String? validateUsername(String? value) => value!.isEmpty
      ? "Enter username"
      : value.contains(RegExp(r'[A-Z]'))
          ? "Username contains uppercase letter"
          : null;

  static String? validatePassword(String? value) =>
      value!.length < 8 ? "Password must be of at least 8 characters" : null;

  static String? validateReenteredPassword(String? value1, String? value2) =>
      value1 == value2 ? null : "Passwords donot match";

  static Future<bool> checkUsername(String? value, BuildContext context) async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .where('username', isEqualTo: value)
        .get()
        .then((data) {
      if (data.docs.isNotEmpty) {
        showSnackBar("Username exists already!", context);
        return false;
      } else {
        return true;
      }
    });
  }
}
