import 'package:email_validator/email_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  static String? validateUsername(String? value) {
    String? val;
    FirebaseFirestore.instance
        .collection("Users")
        .where('username', isEqualTo: value)
        .get()
        .then((data) {
      if (data.docs.isNotEmpty) {
        // print("Username occupied");
        val = "Username exists already";
      } else {
        // print("Username available");
      }
      value!.isEmpty
          ? val = "Enter username"
          : value.contains(RegExp(r'[A-Z]'))
              ? val = "Username contains uppercase letter"
              : null;
    });
    // print(val);
    return val;
  }

  static String? validatePassword(String? value) =>
      value!.length < 8 ? "Password must be of at least 8 characters" : null;

  static String? validateReenteredPassword(String? value1, String? value2) =>
      value1 == value2 ? null : "Passwords donot match";
}
