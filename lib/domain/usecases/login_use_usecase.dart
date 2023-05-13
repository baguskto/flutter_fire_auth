import 'package:firebase_auth/firebase_auth.dart';

import '../repositories/auth_repository.dart';



class LoginUserUseCase {
  final AuthRepository authRepository;

  LoginUserUseCase(this.authRepository);

  Future<UserCredential> execute(String email, String password) {
    return authRepository.loginUser(email, password);
  }
}






