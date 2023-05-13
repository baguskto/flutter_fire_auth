// import 'package:flutter_fire_auth/data/data_source/firebase_user_data_source.dart';
// import 'package:flutter_fire_auth/data/models/user_model.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:test/test.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
//
// class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
// class MockCollectionReference extends Mock implements CollectionReference<Map<String, dynamic>> {}
// class MockQuerySnapshot extends Mock implements QuerySnapshot<Map<String, dynamic>> {}
//
// void main() {
//   late FirebaseUserDataSource dataSource;
//   late FirebaseFirestore mockFirestore;
//   late CollectionReference mockCollectionReference;
//   late QuerySnapshot mockQuerySnapshot;
//
//   setUp(() {
//     mockFirestore = MockFirebaseFirestore();
//     mockCollectionReference = MockCollectionReference();
//     mockQuerySnapshot = MockQuerySnapshot();
//     dataSource = FirebaseUserDataSource();
//
//     when(() => mockFirestore.collection(any())).thenReturn(mockCollectionReference);
//     when(() => mockCollectionReference.snapshots()).thenAnswer((_) => Stream.value(mockQuerySnapshot));
//   });
//
//   test('fetchUsers should return stream of UserModels', () {
//     // Mock a document snapshot
//     final docSnapshot = MockDocumentSnapshot();
//     when(() => docSnapshot.data()).thenReturn({
//       'name': 'John Doe',
//       'email': 'john.doe@example.com',
//       'hasConfirmedEmail': true,
//     });
//
//     // Mock a query document snapshot
//     final queryDocSnapshot = MockQueryDocumentSnapshot();
//     when(() => queryDocSnapshot.data()).thenReturn(docSnapshot.data());
//
//     // Return the document snapshot when the docs getter is called
//     when(() => mockQuerySnapshot.docs).thenReturn([queryDocSnapshot]);
//
//     // Expect that the returned UserModel has the same data as the mocked document snapshot
//     expect(
//       dataSource.fetchUsers(),
//       emitsInOrder([
//         [
//           UserModel(
//             name: 'John Doe',
//             email: 'john.doe@example.com',
//             hasConfirmedEmail: true,
//           ),
//         ],
//         emitsDone,
//       ]),
//     );
//   });
// }

import 'package:flutter_fire_auth/data/data_source/firebase_user_data_source.dart';
import 'package:flutter_fire_auth/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late FirebaseUserDataSource firebaseUserDataSource;
  late FakeFirebaseFirestore firebaseFirestore;

  setUp(() {
    firebaseFirestore = FakeFirebaseFirestore();
    firebaseUserDataSource = FirebaseUserDataSource(db: firebaseFirestore);
  });

  test('fetchUsers should return a list of users', () async {
    // Set up test data
    await firebaseFirestore.collection('users').add({
      'id': '1',
      'name': 'John Doe',
    });

    // Perform the operation
    final usersStream = firebaseUserDataSource.fetchUsers();

    // Verify the results
    expect(usersStream, isA<Stream<List<UserModel>>>());

    usersStream.listen(expectAsync1((users) {
      expect(users, hasLength(1));
      expect(users.first.id, '1');
      expect(users.first.name, 'John Doe');
    }));
  });
}
