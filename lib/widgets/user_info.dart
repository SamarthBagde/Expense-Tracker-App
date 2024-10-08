import 'package:expense_tracker/services/auth.dart';
import 'package:expense_tracker/services/database.dart';
import 'package:flutter/material.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final Database db = Database(uid: _auth.getCurrentUid());

    return FutureBuilder(
      future: Future.wait([
        db.getUserData(),
        db.getTotalExpenseAmount(),
      ]),
      builder: (ctx, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }
        if (snapshot.data != null) {
          final userData = snapshot.data![0].data() as Map<String, dynamic>;
          final double totalAmount = snapshot.data![1] as double;

          return Card(
            margin: const EdgeInsets.all(16),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome\n${userData['firstName']} ${userData['lastName']}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${userData['email']}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Total Expenses: \u{20B9}${totalAmount.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Text("No User Data!");
        }
      },
    );
  }
}
