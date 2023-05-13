import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_fire_auth/data/repositories/firebase_user_database_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FirebaseUserDatabaseRepository userDbRepository;
  late FakeFirebaseFirestore mockFirestore;

  setUp(() {
    mockFirestore = FakeFirebaseFirestore();
    userDbRepository = FirebaseUserDatabaseRepository(mockFirestore);
  });

  const testUid = 'testUid';
  const testName = 'Test';
  const testEmail = 'test@test.com';

  test('should call createUser and update correct document', () async {
    // Act
    await userDbRepository.createUser(testUid, testName, testEmail);

    // Assert
    final userSnapshot =
        await mockFirestore.collection('users').doc(testUid).get();
    expect(userSnapshot.data(),
        {'name': testName, 'email': testEmail, 'hasConfirmedEmail': false});
  });

  test('should call updateUserEmailConfirmation and update correct document',
      () async {
    // Arrange
    await mockFirestore.collection('users').doc(testUid).set({
      'name': testName,
      'email': testEmail,
      'hasConfirmedEmail': false,
    });

    // Act
    await userDbRepository.updateUserEmailConfirmation(testUid, true);

    // Assert
    final userSnapshot =
        await mockFirestore.collection('users').doc(testUid).get();
    expect(userSnapshot['hasConfirmedEmail'], true);
  });
}
