import '../repositories/user_database_repository.dart';

class CreateUserUseCase {
  final UserDatabaseRepository _userDbRepo;

  CreateUserUseCase(this._userDbRepo);

  Future<void> execute(String uid, String name, String email) async {
    await _userDbRepo.createUser(uid, name, email );
  }
}
