import '../../domain/repositories/user_repository.dart';
import '../data_source/firebase_user_data_source.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseUserDataSource dataSource;

  UserRepositoryImpl(this.dataSource);

  @override
  Stream<List<UserModel>> fetchUsers() {
    return dataSource.fetchUsers();
  }
}
