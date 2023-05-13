import 'package:flutter_fire_auth/data/models/user_model.dart';
import 'package:flutter_fire_auth/domain/usecases/filter_users_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FilterUsersUseCase filterUsersUseCase;

  setUp(() {
    filterUsersUseCase = FilterUsersUseCase();
  });

  test('should filter users who have confirmed email', () {
    // Arrange
    final users = [
      UserModel(hasConfirmedEmail: true),
      UserModel(hasConfirmedEmail: false),
      UserModel(hasConfirmedEmail: true),
    ];

    // Act
    final result = filterUsersUseCase.execute(users, true);

    // Assert
    expect(result.length, 2);
    expect(result, [users[0], users[2]]);
  });

  test('should filter users who have not confirmed email', () {
    // Arrange
    final users = [
      UserModel(hasConfirmedEmail: true),
      UserModel(hasConfirmedEmail: false),
      UserModel(hasConfirmedEmail: true),
    ];

    // Act
    final result = filterUsersUseCase.execute(users, false);

    // Assert
    expect(result.length, 1);
    expect(result, [users[1]]);
  });
}
