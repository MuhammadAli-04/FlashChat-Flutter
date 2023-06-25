import 'package:flutter/material.dart';
import '../Components/button.dart';
import '../Components/input_field.dart';
import '../Components/heading.dart';
import 'package:email_validator/email_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const id = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
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
              const Heading(text: "Login "),
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputField(
                      controller: emailController,
                      keyboard: TextInputType.emailAddress,
                      hintText: "Email",
                      icon: Icons.email,
                      validator: (value) {
                        return value!.isEmpty
                            ? "Enter email"
                            : EmailValidator.validate(value)
                                ? null
                                : "Enter valid email";
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    InputField(
                      controller: passwordController,
                      keyboard: TextInputType.text,
                      hintText: "Password",
                      icon: Icons.password,
                      obscureData: true,
                      validator: (value) {
                        return value!.length < 8
                            ? "Password must be of at least 8 characters"
                            : null;
                      },
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    Button(
                      text: "Login",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          emailController.clear();
                          passwordController.clear();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
