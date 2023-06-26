import 'package:email_validator/email_validator.dart';

class Validation {
  static String? validateName(String? value) =>
      value!.contains(RegExp(r'[0-9]')) ? "Invalid name" : null;

  static String? validateEmail(String? value) => value!.isEmpty
      ? "Enter e-mail"
      : EmailValidator.validate(value)
          ? null
          : "Enter valid e-mail";

  static String? validateUsername(String? value) => value!.isEmpty
      ? "Enter username"
      : value.contains(RegExp(r'[A-Z]'))
          ? "Username doesnot contains uppercase letter"
          : null;

  static String? validatePassword(String? value) =>
      value!.length < 8 ? "Password must be of at least 8 characters" : null;
}
