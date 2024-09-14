import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  Database({required this.uid});

  String uid;

  Future<void> addUser(
      String firstName, String lastName, String email, String uid) async {
    try {
      FirebaseFirestore.instance.collection('Users').doc(uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'uid': uid
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addExpense(
      {required String title,
      required String amount,
      required String date,
      required String category
      // required String expenseId,
      }) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('Expenses')
          // .doc(expenseId)
          .add({
        'title': title,
        'amount': amount,
        'date': date,
        'category': category,
        // 'expenseId': expenseId,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateExpense({
    required String title,
    required String amount,
    required String date,
    required String expenseId,
    required String category,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('Expenses')
          .doc(expenseId)
          .set({
        'title': title,
        'amount': amount,
        'date': date,
        'category': category,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteExpense({
    required String expenseId,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('Expenses')
          .doc(expenseId)
          .delete();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<DocumentSnapshot> getUserData() async {
    return FirebaseFirestore.instance.collection('Users').doc(uid).get();
  }

  Future<double> getTotalExpenseAmount() async {
    double totalAmount = 0;
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Expenses')
        .get();

    for (var doc in snapshot.docs) {
      totalAmount += double.tryParse(doc['amount']) ?? 0.0;
    }

    return totalAmount;
  }

  Future<Map<String, double>> getExpenseAmountSummery() async {
    Map<String, double> amounts = {
      'food': 0,
      'travel': 0,
      'work': 0,
      'entertainment': 0,
      'other': 0
    };

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Expenses')
        .get();

    for (var doc in snapshot.docs) {
      amounts[doc['category']] = (amounts[doc['category']] ?? 0.0) +
          (double.tryParse(doc['amount']) ?? 0.0);
    }

    return amounts;
  }
}
