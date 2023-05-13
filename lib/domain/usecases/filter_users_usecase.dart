import '../../data/models/user_model.dart';

class FilterUsersUseCase {
  List<UserModel> execute(List<UserModel> users, bool hasConfirmedEmail) {
    return users.where((user) => user.hasConfirmedEmail == hasConfirmedEmail).toList();
  }
}