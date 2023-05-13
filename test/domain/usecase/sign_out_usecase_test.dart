import 'package:flutter_fire_auth/domain/repositories/auth_repository.dart';
import 'package:flutter_fire_auth/domain/usecases/sign_out_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late SignOutUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = SignOutUseCase(mockAuthRepository);
  });

  test('should call signOut from AuthRepository', () async {
    // Arrange
    when(() => mockAuthRepository.signOut()).thenAnswer((_) async {});

    // Act
    await useCase.execute();

    // Assert
    verify(() => mockAuthRepository.signOut()).called(1);
  });
}
