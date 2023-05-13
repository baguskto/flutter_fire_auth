import 'package:flutter_fire_auth/data/data_source/firebase_auth_data_source.dart';
import 'package:flutter_fire_auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_fire_auth/domain/repositories/user_database_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MockFirebaseAuthDataSource extends Mock
    implements FirebaseAuthDataSource {}

class MockUserDatabaseRepository extends Mock
    implements UserDatabaseRepository {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  late FirebaseAuthRepository authRepository;
  late MockFirebaseAuthDataSource mockDataSource;
  late MockUserDatabaseRepository mockUserDbRepo;

  setUp(() {
    mockDataSource = MockFirebaseAuthDataSource();
    mockUserDbRepo = MockUserDatabaseRepository();
    authRepository = FirebaseAuthRepository(mockDataSource, mockUserDbRepo);
  });

  const testName = 'Test';
  const testEmail = 'test@test.com';
  const testPassword = 'test123';

  test('should call registerUser from FirebaseAuthDataSource', () async {
    // Arrange
    final testCredential = MockUserCredential();
    when(() => mockDataSource.registerUser(testName, testEmail, testPassword))
        .thenAnswer((_) async => testCredential);

    // Act
    final result =
        await authRepository.registerUser(testName, testEmail, testPassword);

    // Assert
    expect(result, testCredential);
    verify(() => mockDataSource.registerUser(testName, testEmail, testPassword))
        .called(1);
  });

  // Add more tests for loginUser, sendPasswordResetEmail, signOut, checkAndUpdateEmailVerification and getCurrentUser
}
