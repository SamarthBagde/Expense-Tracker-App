import 'package:expense_tracker/services/auth.dart';
import 'package:expense_tracker/services/database.dart';
import 'package:flutter/material.dart';

class ExpensesSummery extends StatefulWidget {
  const ExpensesSummery({super.key});

  @override
  State<ExpensesSummery> createState() => _ExpensesSummeryState();
}

class _ExpensesSummeryState extends State<ExpensesSummery> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final Database db = Database(uid: _auth.getCurrentUid());

    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 5,
      child: Column(
        children: [
          const Text(
            "Expenses Summery",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          FutureBuilder(
            future: db.getExpenseAmountSummery(),
            builder: (ctx, AsyncSnapshot<Map<String, double>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              }

              if (snapshot.hasData) {
                final summeyData = snapshot.data!;

                if (snapshot.data != null) {
                  return Column(
                    children: summeyData.entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 7, left: 8, right: 8, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(entry.key, style: TextStyle(fontSize: 16)),
                            Text(entry.value.toString(),
                                style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                } else {
                  return const Text("No Data Available!");
                }
              } else {
                return const Text("No User Data!");
              }
            },
          )
        ],
      ),
    );
  }
}
