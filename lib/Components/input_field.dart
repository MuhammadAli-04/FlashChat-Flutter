import 'package:flutter/material.dart';
import 'package:chat_app/utilities/constants.dart';

class InputField extends StatefulWidget {
  InputField(
      {super.key,
      required this.controller,
      this.hintText = "",
      this.icon,
      this.obscureData = false,
      required this.keyboard,
      required this.validator});

  final TextEditingController controller;
  final TextInputType keyboard;
  String hintText;
  IconData? icon;
  bool obscureData;
  final String? Function(String?) validator;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool? showPassword;

  @override
  void initState() {
    super.initState();
    showPassword = widget.obscureData;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: kInputDecoration.copyWith(
        labelText: widget.hintText,
        prefixIcon: Icon(widget.icon),
        suffixIcon: widget.obscureData
            ? showPassword!
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword!;
                      });
                    },
                    icon: const Icon(Icons.visibility))
                : IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword!;
                      });
                    },
                    icon: const Icon(Icons.visibility_off))
            : null,
      ),
      obscureText: showPassword!,
      keyboardType: widget.keyboard,
      validator: widget.validator,
    );
  }
}
