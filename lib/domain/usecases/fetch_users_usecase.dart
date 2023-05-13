import '../../data/models/user_model.dart';
import '../repositories/user_repository.dart';

class FetchUsersUseCase {
  final UserRepository repository;

  FetchUsersUseCase(this.repository);

  Stream<List<UserModel>> execute() {
    return repository.fetchUsers();
  }
}


