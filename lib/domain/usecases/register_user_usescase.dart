import 'package:firebase_auth/firebase_auth.dart';

import '../repositories/auth_repository.dart';

class RegisterUserUseCase {
  final AuthRepository authRepository;

  RegisterUserUseCase(this.authRepository);

  Future<UserCredential> execute(String name, String email, String password) {
    return authRepository.registerUser(name, email, password);
  }
}
