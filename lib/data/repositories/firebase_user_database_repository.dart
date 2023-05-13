import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/repositories/user_database_repository.dart';

// class FirebaseUserDatabaseRepository implements UserDatabaseRepository {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//
//   @override
//   Future<void> updateUserEmailConfirmation(String uid, bool hasConfirmedEmail) {
//     return _db.collection('users').doc(uid).update({'hasConfirmedEmail': hasConfirmedEmail});
//   }
//
//   @override
//   Future<void> createUser(String uid, String name, String email) {
//     return _db.collection('users').doc(uid).set({
//       'name': name,
//       'email': email,
//       'hasConfirmedEmail': false,
//     });
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUserDatabaseRepository implements UserDatabaseRepository {
  final FirebaseFirestore _firestore;

  FirebaseUserDatabaseRepository(this._firestore);

  @override
  Future<void> createUser(String uid, String name, String email) async {
    await _firestore.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'hasConfirmedEmail': false,
    });
  }

  @override
  Future<void> updateUserEmailConfirmation(String uid, bool hasConfirmedEmail) async {
    await _firestore.collection('users').doc(uid).update({
      'hasConfirmedEmail': hasConfirmedEmail,
    });
  }
}
