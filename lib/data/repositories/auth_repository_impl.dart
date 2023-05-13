import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/user_database_repository.dart';
import '../data_source/firebase_auth_data_source.dart';



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

  User? getCurrentUser() {
    return _dataSource.getCurrentUser();
  }
}

