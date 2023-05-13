import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<UserCredential> registerUser(String name, String email, String password);
  Future<UserCredential> loginUser(String email, String password);
  Future<void> sendPasswordResetEmail(String email);
  Future<void> signOut();
  Future<void> checkAndUpdateEmailVerification();
}


