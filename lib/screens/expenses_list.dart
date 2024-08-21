import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/screens/expense.dart';

class ExpensesList extends StatefulWidget {
  const ExpensesList({super.key});

  @override
  State<ExpensesList> createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final uid = _auth.getCurrentUid();
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(uid)
            .collection('Expenses')
            .snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          if (snapshot.data != null) {
            final expensesList = snapshot.data!.docs;

            if (expensesList.isEmpty) {
              return const Center(
                child: Text("No Expenses yet"),
              );
            }

            return ListView.builder(
                itemCount: expensesList.length,
                itemBuilder: (ctx, index) {
                  final data =
                      expensesList[index].data() as Map<String, dynamic>;
                  String expenseId = expensesList[index].id;

                  return Expesnse(
                    title: capitalize(data['title']),
                    amount: data['amount'],
                    date: data['date'].toString(),
                    expenseId: expenseId,
                    category: data['category'].toString(),
                  );
                });
          } else {
            return const Text("No Data!");
          }
        },
      ),
    );
  }
}
