import 'package:flutter_fire_auth/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('UserModel should be created from JSON', () {
    // Arrange
    final json = {
      'id': '1',
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'hasConfirmedEmail': true,
    };

    // Act
    final userModel = UserModel.fromJson(json);

    // Assert
    expect(userModel.id, '1');
    expect(userModel.name, 'John Doe');
    expect(userModel.email, 'john.doe@example.com');
    expect(userModel.hasConfirmedEmail, true);
  });

  test('UserModel should be converted to JSON', () {
    // Arrange
    final userModel = UserModel(
      id: '1',
      name: 'John Doe',
      email: 'john.doe@example.com',
      hasConfirmedEmail: true,
    );

    // Act
    final json = userModel.toJson();

    // Assert
    expect(json['id'], '1');
    expect(json['name'], 'John Doe');
    expect(json['email'], 'john.doe@example.com');
    expect(json['hasConfirmedEmail'], true);
  });
}