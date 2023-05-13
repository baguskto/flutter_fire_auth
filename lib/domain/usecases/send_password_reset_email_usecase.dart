import '../repositories/auth_repository.dart';

class SendPasswordResetEmailUseCase {
  final AuthRepository authRepository;

  SendPasswordResetEmailUseCase(this.authRepository);

  Future<void> execute(String email) {
    return authRepository.sendPasswordResetEmail(email);
  }
}