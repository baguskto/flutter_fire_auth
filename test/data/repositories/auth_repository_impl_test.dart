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

class MockUser extends Mock implements User {}

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

  test('should call loginUser from FirebaseAuthDataSource', () async {
    // Arrange
    final testCredential = MockUserCredential();
    when(() => mockDataSource.loginUser(testEmail, testPassword))
        .thenAnswer((_) async => testCredential);

    // Act
    final result = await authRepository.loginUser(testEmail, testPassword);

    // Assert
    expect(result, testCredential);
    verify(() => mockDataSource.loginUser(testEmail, testPassword)).called(1);
  });

  test('should call sendPasswordResetEmail from FirebaseAuthDataSource',
      () async {
    // Arrange
    when(() => mockDataSource.sendPasswordResetEmail(testEmail))
        .thenAnswer((_) async => null);

    // Act
    await authRepository.sendPasswordResetEmail(testEmail);

    // Assert
    verify(() => mockDataSource.sendPasswordResetEmail(testEmail)).called(1);
  });

  test('should call signOut from FirebaseAuthDataSource', () async {
    // Arrange
    when(() => mockDataSource.signOut()).thenAnswer((_) async => null);

    // Act
    await authRepository.signOut();

    // Assert
    verify(() => mockDataSource.signOut()).called(1);
  });

  // test('should call checkAndUpdateEmailVerification and updateUserEmailConfirmation', () async {
  //   // Arrange
  //   final testUid = '123';
  //   final testUser = MockUser(uid: testUid);
  //   when(() => mockDataSource.checkAndUpdateEmailVerification())
  //       .thenAnswer((_) async => true);
  //   when(() => mockDataSource.getCurrentUser()).thenReturn(testUser);
  //   when(() => mockUserDbRepo.updateUserEmailConfirmation(testUid, true))
  //       .thenAnswer((_) async => null);
  //
  //   // Act
  //   await authRepository.checkAndUpdateEmailVerification();
  //
  //   // Assert
  //   verify(() => mockDataSource.checkAndUpdateEmailVerification()).called(1);
  //   verify(() => mockUserDbRepo.updateUserEmailConfirmation(testUid, true))
  //       .called(1);
  // });

  test(
      'should call checkAndUpdateEmailVerification and updateUserEmailConfirmation',
      () async {
    // Arrange
    final testUid = '123';
    final testUser = MockUser();
    when(() => testUser.uid).thenReturn(testUid);
    when(() => mockDataSource.checkAndUpdateEmailVerification())
        .thenAnswer((_) async => true);
    when(() => mockDataSource.getCurrentUser()).thenReturn(testUser);
    when(() => mockUserDbRepo.updateUserEmailConfirmation(testUid, true))
        .thenAnswer((_) async => null);

    // Act
    await authRepository.checkAndUpdateEmailVerification();

    // Assert
    verify(() => mockDataSource.checkAndUpdateEmailVerification()).called(1);
    verify(() => mockUserDbRepo.updateUserEmailConfirmation(testUid, true))
        .called(1);
  });
  test('should call getCurrentUser from FirebaseAuthDataSource', () async {
    // Arrange
    final testUid = '123';
    final testUser = MockUser();
    when(() => testUser.uid).thenReturn(testUid);
    when(() => mockDataSource.getCurrentUser()).thenReturn(testUser);

    // Act
    final result = authRepository.getCurrentUser();

    // Assert
    expect(result, testUser);
    verify(() => mockDataSource.getCurrentUser()).called(1);
  });
}
