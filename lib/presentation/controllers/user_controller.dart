import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_fire_auth/presentation/controllers/auth_controller.dart';
import 'package:get/get.dart';

import '../../data/models/user_model.dart';
import '../../domain/usecases/check_and_update_email_verification_usecase.dart';
import '../../domain/usecases/fetch_users_usecase.dart';
import '../../domain/usecases/filter_users_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import '../navigations/app_routes.dart';

class UserController extends GetxController {
  RxList<UserModel> userList = RxList<UserModel>();
  RxList<UserModel> filteredUsers = RxList<UserModel>();
  final FetchUsersUseCase fetchUsersUseCase;
  final FilterUsersUseCase filterUsersUseCase;
  final SignOutUseCase signOutUseCase;
  final CheckAndUpdateEmailVerificationUseCase
      checkAndUpdateEmailVerificationUseCase;

  UserController(this.fetchUsersUseCase, this.filterUsersUseCase,
      this.signOutUseCase, this.checkAndUpdateEmailVerificationUseCase);

  List<UserModel> get users => userList.value;
  RxBool isHomeLoading = false.obs;

  @override
  void onInit() {
    userList.bindStream(
        fetchUsersUseCase.execute()); // fetch user data on initialization
    ever(userList, (_) {
      // Update filteredUsers every time userList changes
      filteredUsers.assignAll(userList.value);
    });
    super.onInit();
  }

  // Filter user data
  void filterUsers(bool hasConfirmedEmail) {
    filteredUsers.value = filterUsersUseCase.execute(users, hasConfirmedEmail);
  }

  Future<void> signOut() async {
    try {
      await signOutUseCase.execute();
      Get.offAllNamed(AppRoutes.AUTH);
    } catch (e) {
      Get.snackbar('Error signing out:', e.toString());
    }
  }

  Future<void> refreshStatusUser() async {
    isHomeLoading.toggle();
    try {
      await checkAndUpdateEmailVerificationUseCase.execute();
      userList.refresh();
      isHomeLoading.toggle();
    } catch (e) {
      isHomeLoading.toggle();
      Get.snackbar('Failed', e.toString());
    }
  }
}


