import 'package:flutter_fire_auth/data/models/user_model.dart';
import 'package:flutter_fire_auth/domain/repositories/user_repository.dart';
import 'package:flutter_fire_auth/domain/usecases/fetch_users_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
// Create a MockUserRepository class
class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late FetchUsersUseCase fetchUsersUseCase;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    fetchUsersUseCase = FetchUsersUseCase(mockUserRepository);
  });

  test('should call fetchUsers method from UserRepository', () {
    // Arrange
    final users = Stream.value([UserModel()]); // replace with actual user list
    when(() => mockUserRepository.fetchUsers()).thenAnswer((_) => users);

    // Act
    final result = fetchUsersUseCase.execute();

    // Assert
    expect(result, users);
    verify(() => mockUserRepository.fetchUsers()).called(1);
  });
}
