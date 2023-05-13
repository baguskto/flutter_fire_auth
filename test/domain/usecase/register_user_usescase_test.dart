import 'package:flutter_fire_auth/domain/repositories/auth_repository.dart';
import 'package:flutter_fire_auth/domain/usecases/register_user_usescase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  late RegisterUserUseCase useCase;
  late MockAuthRepository mockAuthRepository;
  final testEmail = 'test@example.com';
  final testName = 'Test User';
  final testPassword = 'password123';

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = RegisterUserUseCase(mockAuthRepository);
  });

  test('should call registerUser from AuthRepository', () async {
    // Arrange
    when(() =>
            mockAuthRepository.registerUser(testName, testEmail, testPassword))
        .thenAnswer((_) async => MockUserCredential());

    // Act
    await useCase.execute(testName, testEmail, testPassword);

    // Assert
    verify(() =>
            mockAuthRepository.registerUser(testName, testEmail, testPassword))
        .called(1);
  });
}
