// ignore_for_file: use_build_context_synchronously
import "package:flutter/material.dart";

import "package:expense_tracker/services/auth.dart";
import "package:expense_tracker/services/database.dart";

class EditExpense extends StatefulWidget {
  const EditExpense(
      {super.key,
      required this.oldTitle,
      required this.oldAmount,
      required this.expenseId,
      required this.date,
      required this.category});

  final String oldTitle, expenseId, date, category;
  final double oldAmount;

  @override
  State<EditExpense> createState() => _EditExpenseState();
}

class _EditExpenseState extends State<EditExpense> {
  final AuthService _auth = AuthService();
  late TextEditingController _titleController;
  late TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.oldTitle);
    _amountController =
        TextEditingController(text: widget.oldAmount.toString());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uid = _auth.getCurrentUid();
    final Database database = Database(uid: uid);
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              label: const Text('New Expense Title'),
              hintText: widget.oldTitle,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              label: const Text('New Amount'),
              hintText: widget.oldAmount.toString(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              final double amount = double.parse(_amountController.text);
              await database.updateExpense(
                  title: _titleController.text,
                  amount: amount,
                  date: widget.date,
                  expenseId: widget.expenseId,
                  category: widget.category);
              Navigator.of(context).pop();
            },
            child: const Text('Submit'),
          )
        ],
      ),
    );
  }
}
