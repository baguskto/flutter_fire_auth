import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_fire_auth/presentation/controllers/auth_controller.dart';
import 'package:get/get.dart';

import '../../data/models/user_model.dart';

class UserController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  RxList<UserModel> userList = RxList<UserModel>();
  RxList<UserModel> filteredUsers = RxList<UserModel>();
  AuthController authController = Get.find<AuthController>();

  List<UserModel> get users => userList.value;

  @override
  void onInit() {
    userList.bindStream(fetchUsers()); // fetch user data on initialization
    ever(userList, (_) {
      // Update filteredUsers every time userList changes
      filteredUsers.assignAll(userList.value);
    });
    print('asu ${filteredUsers.isEmpty}');
    super.onInit();
  }

  // Fetch user data
  Stream<List<UserModel>> fetchUsers() {
    return _db.collection('users').snapshots().map((query) =>
        query.docs.map((item) => UserModel.fromJson(item.data())).toList());
  }

  // Filter user data
  void filterUsers(bool hasConfirmedEmail) {
    filteredUsers.value = users
        .where((user) => user.hasConfirmedEmail == hasConfirmedEmail)
        .toList();
  }
}
