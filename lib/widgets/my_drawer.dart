import 'package:expense_tracker/widgets/expenses_summery.dart';
import 'package:expense_tracker/widgets/user_info.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding:
            const EdgeInsets.only(top: 35, bottom: 35, right: 10, left: 10),
        children: const [
          UserInfo(),
          ExpensesSummery(),
        ],
      ),
    );
  }
}
