import 'package:expense_tracker/screens/login.dart';
import 'package:expense_tracker/screens/signup.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool loginScreen = true;

  void toggle() {
    setState(() {
      loginScreen = !loginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loginScreen) {
      return Login(
        toggle: toggle,
      );
    } else {
      return Signup(
        toggle: toggle,
      );
    }
  }
}
