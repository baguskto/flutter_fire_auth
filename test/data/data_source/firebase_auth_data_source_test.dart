import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_fire_auth/data/data_source/firebase_auth_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../domain/usecase/register_user_usescase_test.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

void main() {
  late FirebaseAuthDataSource authDataSource;
  late MockFirebaseAuth mockAuth;
  late MockUserCredential mockUserCredential;
  late MockUser mockUser;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    mockUserCredential = MockUserCredential();
    mockUser = MockUser();
    authDataSource = FirebaseAuthDataSource(auth: mockAuth);

  });

  group('registerUser', () {
    final testName = 'Pudidi';
    final testEmail = 'test@test.com';
    final testPassword = 'Test1234';

    test('should call createUserWithEmailAndPassword with correct parameters',
        () async {
      // arrange
      when(() => mockAuth.createUserWithEmailAndPassword(
          email: testEmail,
          password: testPassword)).thenAnswer((_) async => mockUserCredential);

      // act
      final result =
          await authDataSource.registerUser(testName, testEmail, testPassword);

      // assert
      verify(() => mockAuth.createUserWithEmailAndPassword(
          email: testEmail, password: testPassword)).called(1);
      expect(result, equals(mockUserCredential));
    });
  });

  group('loginUser', () {
    final testEmail = 'test@test.com';
    final testPassword = 'Test1234';

    test('should call signInWithEmailAndPassword with correct parameters',
        () async {
      // arrange
      when(() => mockAuth.signInWithEmailAndPassword(
          email: testEmail,
          password: testPassword)).thenAnswer((_) async => mockUserCredential);

      // act
      final result = await authDataSource.loginUser(testEmail, testPassword);

      // assert
      verify(() => mockAuth.signInWithEmailAndPassword(
          email: testEmail, password: testPassword)).called(1);
      expect(result, equals(mockUserCredential));
    });
  });

  group('sendPasswordResetEmail', () {
    final testEmail = 'test@test.com';

    test('should call sendPasswordResetEmail with correct parameters',
        () async {
      // arrange
      when(() => mockAuth.sendPasswordResetEmail(email: testEmail))
          .thenAnswer((_) async {});

      // act
      await authDataSource.sendPasswordResetEmail(testEmail);

      // assert
      verify(() => mockAuth.sendPasswordResetEmail(email: testEmail)).called(1);
    });
  });

  group('signOut', () {
    test('should call signOut', () async {
      // arrange
      when(() => mockAuth.signOut()).thenAnswer((_) async {});

      // act
      await authDataSource.signOut();

      // assert
      verify(() => mockAuth.signOut()).called(1);
    });
  });

  group('checkAndUpdateEmailVerification', () {
    test('should call currentUser, reload and emailVerified', () async {
      // arrange
      when(() => mockAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.reload()).thenAnswer((_) async {});
      when(() => mockUser.emailVerified).thenReturn(true);

      // act
      final result = await authDataSource.checkAndUpdateEmailVerification();

      // assert
      verify(() => mockAuth.currentUser).called(2);
      verify(() => mockUser.reload()).called(1);
      verify(() => mockUser.emailVerified).called(1);
      expect(result, equals(true));
    });
  });

  group('getCurrentUser', () {
    test('should call currentUser', () async {

      // arrange
      when(() => mockAuth.currentUser).thenReturn(mockUser);

      // act
      final result = authDataSource.getCurrentUser();

      // assert
      verify(() => mockAuth.currentUser).called(1);
      expect(result, equals(mockUser));

      // additional cleanup
      verifyNoMoreInteractions(mockAuth);
    });
  });


}
