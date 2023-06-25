import 'package:flutter/material.dart';
import '../Components/input_field.dart';
import '../Components/button.dart';
import 'package:email_validator/email_validator.dart';
import '../Components/heading.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  static const id = "SignupScreen";

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'logo',
                child: Image.asset(
                  'images/logo.png',
                  height: 150.0,
                ),
              ),
              const Heading(text: "Register"),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    InputField(
                      controller: emailController,
                      keyboard: TextInputType.emailAddress,
                      validator: (value) => value!.isEmpty
                          ? "Enter e-mail"
                          : EmailValidator.validate(value)
                              ? null
                              : "Enter valid e-mail",
                      hintText: "Email",
                      icon: Icons.email,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    InputField(
                      controller: passwordController,
                      keyboard: TextInputType.text,
                      validator: (value) => value!.length < 8
                          ? "Password must be of at least 8 characters"
                          : null,
                      hintText: "Password",
                      icon: Icons.password,
                      obscureData: true,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Button(
                      text: "Register",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          emailController.clear();
                          passwordController.clear();
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
