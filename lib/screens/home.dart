import 'package:expense_tracker/widgets/add_expense.dart';
import 'package:expense_tracker/widgets/expenses_list.dart';
import 'package:expense_tracker/widgets/my_drawer.dart';
import 'package:expense_tracker/services/auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();

  bool sortInc = true;

  void _addExpense() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => const AddExpense(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color.fromARGB(255, 75, 125, 251),
        extendedPadding: const EdgeInsetsDirectional.all(20),
        onPressed: _addExpense,
        label: const Text(
          "Add",
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      drawer: const MyDrawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text(
                      'Are you sure you would like to log out ?',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 75, 125, 251),
                        ),
                        onPressed: () {
                          _auth.signOut();
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Log Out",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.logout))
        ],
        backgroundColor: const Color.fromARGB(255, 75, 125, 251),
        title: const Text(
          'Home Screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Container(
            // height: containerHeight,
            padding: const EdgeInsetsDirectional.all(12),
            child: ExpensesList(
              sortInc: sortInc,
            ),
          ),
          Positioned(
            bottom: 16.0, // Distance from the bottom
            left: 16.0, // Distance from the left
            child: IconButton(
              style: IconButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 75, 125, 251),
              ),
              onPressed: () {
                setState(() {
                  sortInc = !sortInc;
                });
              },
              icon: const Icon(
                Icons.filter_alt_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
