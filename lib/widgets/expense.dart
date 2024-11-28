import 'package:expense_tracker/widgets/delete_expense.dart';
import 'package:expense_tracker/widgets/edit_expense.dart';
import 'package:flutter/material.dart';

class Expesnse extends StatelessWidget {
  const Expesnse({
    super.key,
    required this.title,
    required this.amount,
    required this.date,
    required this.expenseId,
    required this.category,
  });

  final String title;
  final String amount;
  final String date;
  final String expenseId;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsetsDirectional.only(
          bottom: 12, top: 12, start: 16, end: 16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: () {
                  // print(expenseId);
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                        'Edit Expense',
                        style: TextStyle(fontSize: 16),
                      ),
                      actions: [
                        EditExpense(
                          oldTitle: title,
                          oldAmount: double.parse(amount),
                          expenseId: expenseId,
                          date: date,
                          category: category,
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => DeleteExpense(
                      expenseId: expenseId,
                    ),
                  );
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              category[0].toUpperCase() + category.substring(1),
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "$amount \u{20B9}",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
