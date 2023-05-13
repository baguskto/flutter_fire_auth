import 'package:flutter_fire_auth/domain/repositories/auth_repository.dart';
import 'package:flutter_fire_auth/domain/usecases/check_and_update_email_verification_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late CheckAndUpdateEmailVerificationUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = CheckAndUpdateEmailVerificationUseCase(mockAuthRepository);
  });

  test('should call checkAndUpdateEmailVerification from AuthRepository',
      () async {
    // Arrange
    when(() => mockAuthRepository.checkAndUpdateEmailVerification())
        .thenAnswer((_) async {});

    // Act
    await useCase.execute();

    // Assert
    verify(() => mockAuthRepository.checkAndUpdateEmailVerification())
        .called(1);
  });
}
