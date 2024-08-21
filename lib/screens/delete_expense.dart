import 'package:expense_tracker/services/auth.dart';
import 'package:expense_tracker/services/database.dart';
import 'package:flutter/material.dart';

class DeleteExpense extends StatelessWidget {
  DeleteExpense({super.key, required this.expenseId});
  final String expenseId;
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final uid = _auth.getCurrentUid();
    final Database _database = Database(uid: uid);
    return AlertDialog(
      title: const Text(
        'Confirm that you want to delete this Expense!',
        style: TextStyle(fontSize: 16),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            _database.deleteExpense(expenseId: expenseId);
            Navigator.of(context).pop();
          },
          child: const Text('Delete Expense!'),
        ),
      ],
    );
  }
}
