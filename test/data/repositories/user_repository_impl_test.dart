import 'package:flutter_fire_auth/data/data_source/firebase_user_data_source.dart';
import 'package:flutter_fire_auth/data/models/user_model.dart';
import 'package:flutter_fire_auth/data/repositories/user_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseUserDataSource extends Mock
    implements FirebaseUserDataSource {}

void main() {
  late UserRepositoryImpl userRepository;
  late MockFirebaseUserDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockFirebaseUserDataSource();
    userRepository = UserRepositoryImpl(mockDataSource);
  });

  test('should fetch users from the data source', () async {
    // arrange
    final List<UserModel> userList = [
      UserModel(
          name: 'Test', email: 'test@example.com', hasConfirmedEmail: false)
    ];
    final Stream<List<UserModel>> userStream = Stream.value(userList);

    when(() => mockDataSource.fetchUsers()).thenAnswer((_) => userStream);

    // act
    final result = userRepository.fetchUsers();

    // assert
    expect(result, equals(userStream));
    verify(() => mockDataSource.fetchUsers()).called(1);
  });
}
