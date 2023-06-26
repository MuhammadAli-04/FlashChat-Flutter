import 'package:flutter/material.dart';
import 'Screens/welcome_screen.dart';
import 'Screens/login_screen.dart';
import 'Screens/signup_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    print(e);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        SignupScreen.id: (context) => const SignupScreen(),
      },
      initialRoute: WelcomeScreen.id,
      debugShowCheckedModeBanner: false,
      title: 'Flash Chat',
      theme: ThemeData.light(),
    );
  }
}
