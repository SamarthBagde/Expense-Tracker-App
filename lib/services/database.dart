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
        'eamil': email,
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
}
