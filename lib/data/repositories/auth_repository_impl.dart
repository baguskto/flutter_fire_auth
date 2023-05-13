import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/user_database_repository.dart';
import '../data_source/firebase_auth_data_source.dart';

// class FirebaseAuthRepository implements AuthRepository {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   @override
//   Future<UserCredential> registerUser(String name, String email, String password) {
//     return _auth.createUserWithEmailAndPassword(email: email, password: password);
//   }
//
//   @override
//   Future<UserCredential> loginUser(String email, String password) {
//     return _auth.signInWithEmailAndPassword(email: email, password: password);
//   }
//
//   @override
//   Future<void> sendPasswordResetEmail(String email) {
//     return _auth.sendPasswordResetEmail(email: email);
//   }
//
//   @override
//   Future<void> signOut() {
//     return _auth.signOut();
//   }
//
//   @override
//   Future<void> checkAndUpdateEmailVerification() async {
//     User? user = _auth.currentUser;
//     if (user != null) {
//       await user.reload();
//       user = _auth.currentUser;
//       bool hasConfirmedEmail = user!.emailVerified;
//       Get.find<UserDatabaseRepository>().updateUserEmailConfirmation(user.uid, hasConfirmedEmail);
//     }
//   }
// }


class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuthDataSource _dataSource;
  final UserDatabaseRepository _userDbRepo;

  FirebaseAuthRepository(this._dataSource, this._userDbRepo);

  @override
  Future<UserCredential> registerUser(String name, String email, String password) {
    return _dataSource.registerUser(name, email, password);
  }

  @override
  Future<UserCredential> loginUser(String email, String password) {
    return _dataSource.loginUser(email, password);
  }

  @override
  Future<void> sendPasswordResetEmail(String email) {
    return _dataSource.sendPasswordResetEmail(email);
  }

  @override
  Future<void> signOut() {
    return _dataSource.signOut();
  }

  @override
  Future<void> checkAndUpdateEmailVerification() async {
    bool hasConfirmedEmail = await _dataSource.checkAndUpdateEmailVerification();
    User? user = _dataSource.getCurrentUser();
    if (user != null) {
      _userDbRepo.updateUserEmailConfirmation(user.uid, hasConfirmedEmail);
    }
  }

  @override
  User? getCurrentUser() {
    return _dataSource.getCurrentUser();
  }
}

