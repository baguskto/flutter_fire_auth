abstract class UserDatabaseRepository {
  Future<void> updateUserEmailConfirmation(String uid, bool hasConfirmedEmail);
  Future<void> createUser(String uid, String name, String email);
}