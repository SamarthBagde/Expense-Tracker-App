import 'package:expense_tracker/models/user_model.dart';
import 'package:expense_tracker/screens/wrapper.dart';
import 'package:expense_tracker/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyAWY0AD8M7vBX2yI4p0MwXH2bihNjqLRbQ',
          appId: '1:102049640256:android:a848613e942678354a54a5',
          messagingSenderId: '102049640256',
          projectId: 'expense-tracker-app-9cd88'));
  runApp(const ExpenseApp());
}

class ExpenseApp extends StatelessWidget {
  const ExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      initialData: null,
      value: AuthService().user,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
