import 'package:expense_tracker/models/user_model.dart';
import 'package:expense_tracker/screens/authenticate.dart';
import 'package:expense_tracker/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    if (user == null) {
      return const Authenticate();
    } else {
      return const HomePage();
    }
  }
}
