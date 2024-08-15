import 'package:e_thela_dental_bot/screens/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../logger/log_printer.dart';
import 'home_screen.dart';


class AuthenticationFlowScreen extends StatelessWidget {

  AuthenticationFlowScreen({super.key});
  
  static String id = 'main screen';
  // Create a logger instance
  final logger = Logger(printer: SimpleLogPrinter('AuthenticationFlowScreen: '),
  level: Level.all);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            logger.i("Entering Home Screen");
            return const HomeScreen();
          } else {
            logger.i("Entering Sign Up Screen");
            return const SignupScreen();
          }
        },
      ),
    );
  }
}