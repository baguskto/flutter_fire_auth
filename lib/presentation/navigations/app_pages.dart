import 'package:get/get.dart';
import '../bindings/auth_binding.dart';
import '../views/views.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.AUTH,
      page: () => AuthenticationView(),
      binding: AuthBinding(),
    ),
    // GetPage(
    //   name: AppRoutes.REGISTER,
    //   page: () => RegisterView(),
    //   binding: AuthBinding(),
    // ),
    GetPage(
      name: AppRoutes.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomeView(),
      binding: AuthBinding(),
    ),
  ];
}
