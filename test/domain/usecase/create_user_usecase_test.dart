import 'package:flutter_fire_auth/domain/repositories/user_database_repository.dart';
import 'package:flutter_fire_auth/domain/usecases/create_user_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
// Create a MockUserDatabaseRepository class
class MockUserDatabaseRepository extends Mock implements UserDatabaseRepository {}

void main() {
  late CreateUserUseCase createUserUseCase;
  late MockUserDatabaseRepository mockUserDatabaseRepository;

  setUp(() {
    mockUserDatabaseRepository = MockUserDatabaseRepository();
    createUserUseCase = CreateUserUseCase(mockUserDatabaseRepository);
  });

  test('should call createUser method from UserDatabaseRepository', () async {
    // Arrange
    final uid = 'testUid';
    final name = 'testName';
    final email = 'testEmail@test.com';
    when(() => mockUserDatabaseRepository.createUser(uid, name, email)).thenAnswer((_) async => {});

    // Act
    await createUserUseCase.execute(uid, name, email);

    // Assert
    verify(() => mockUserDatabaseRepository.createUser(uid, name, email)).called(1);
  });
}
