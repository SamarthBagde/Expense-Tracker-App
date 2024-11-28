// import 'package:expense_tracker/services/auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:rxdart/rxdart.dart';

// class MockFirebaseAuth extends Mock implements FirebaseAuth {}

// class MockFirebaseUser extends Mock implements User {}

// class MockAuthResult extends Mock implements UserCredential {}

// void main() {
//   MockFirebaseAuth _auth = MockFirebaseAuth();

//   BehaviorSubject<MockFirebaseUser> _user = BehaviorSubject<MockFirebaseUser>();
//   AuthService _repo = AuthService();
//   group("User repository test", () {
//     when(_auth.signInWithEmailAndPassword(email: "email", password: "password"))
//         .thenAnswer((_) async {
//       _user.add(MockFirebaseUser());
//       return MockAuthResult();
//     });

//     test("Sign in", () async {
//       bool signedIn = await _repo.signUp(email: "email", password: "password");
//       expect(signedIn, true);
//     });

//     test("Sign out", () async {});
//   });
// }
