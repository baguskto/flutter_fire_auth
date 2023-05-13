import 'package:flutter_fire_auth/domain/repositories/auth_repository.dart';
import 'package:flutter_fire_auth/domain/usecases/send_password_reset_email_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late SendPasswordResetEmailUseCase useCase;
  late MockAuthRepository mockAuthRepository;
  final testEmail = 'test@example.com';

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = SendPasswordResetEmailUseCase(mockAuthRepository);
  });

  test('should call sendPasswordResetEmail from AuthRepository', () async {
    // Arrange
    when(() => mockAuthRepository.sendPasswordResetEmail(testEmail))
        .thenAnswer((_) async {});

    // Act
    await useCase.execute(testEmail);

    // Assert
    verify(() => mockAuthRepository.sendPasswordResetEmail(testEmail)).called(1);
  });
}
