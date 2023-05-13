import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/user_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => UserController());
  }
}
