import '../../data/models/user_model.dart';

abstract class UserRepository {
  Stream<List<UserModel>> fetchUsers();
}