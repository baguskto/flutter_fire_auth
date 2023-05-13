import '../repositories/auth_repository.dart';

class CheckAndUpdateEmailVerificationUseCase {
  final AuthRepository authRepository;

  CheckAndUpdateEmailVerificationUseCase(this.authRepository);

  Future<void> execute() {
    return authRepository.checkAndUpdateEmailVerification();
  }
}