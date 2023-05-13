import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_auth/presentation/navigations/app_routes.dart';
import 'package:get/get.dart';

import '../../domain/core/helper/validation_helper.dart';
import '../../domain/usecases/check_and_update_email_verification_usecase.dart';
import '../../domain/usecases/create_user_usecase.dart';
import '../../domain/usecases/login_use_usecase.dart';
import '../../domain/usecases/register_user_usescase.dart';
import '../../domain/usecases/send_password_reset_email_usecase.dart';

class AuthController extends GetxController {
  final RegisterUserUseCase registerUserUseCase;
  final LoginUserUseCase loginUserUseCase;
  final SendPasswordResetEmailUseCase sendPasswordResetEmailUseCase;
  final CheckAndUpdateEmailVerificationUseCase
      checkAndUpdateEmailVerificationUseCase;
  final CreateUserUseCase createUserUseCase;

  AuthController(
    this.registerUserUseCase,
    this.loginUserUseCase,
    this.sendPasswordResetEmailUseCase,
    this.checkAndUpdateEmailVerificationUseCase,
    this.createUserUseCase,
  );

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signupNameController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController signupConfirmPasswordController =
      TextEditingController();
  final TextEditingController fpEmailController = TextEditingController();

  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey3 = GlobalKey<FormState>();

  final RxBool obscureTextPassword = true.obs;
  final RxBool obscureTextConfirmPassword = true.obs;

  late PageController pageController;

  RxBool isAuthLoginLoading = false.obs;
  RxBool isAuthForgotPassLoading = false.obs;
  RxBool isAuthRegisterLoading = false.obs;

  RxBool isLeft = true.obs;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  Future<void> registerUser(String name, String email, String password) async {
    isAuthRegisterLoading.toggle();

    try {
      UserCredential userCredential =
          await registerUserUseCase.execute(name, email, password);
      userCredential.user?.sendEmailVerification();
      await createUserUseCase.execute(userCredential.user!.uid, name, email);
      isAuthRegisterLoading.toggle();
      Get.offAndToNamed(AppRoutes.HOME);
      Get.snackbar('Email Confirmation Sent',
          'Please check your email for a link to confirm your account.');
    } catch (e) {
      isAuthRegisterLoading.toggle();
      Get.snackbar('Failed', e.toString());
    }
  }

  Future<void> loginUser(String email, String password) async {
    isAuthLoginLoading.toggle();
    try {
      await loginUserUseCase.execute(email, password);
      await checkAndUpdateEmailVerificationUseCase.execute();
      isAuthLoginLoading.toggle();
      Get.offAndToNamed(AppRoutes.HOME);
    } catch (e) {
      isAuthLoginLoading.toggle();
      Get.snackbar('Failed', e.toString());
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    isAuthForgotPassLoading.toggle();
    try {
      await sendPasswordResetEmailUseCase.execute(email);
      isAuthForgotPassLoading.toggle();
      Get.snackbar('Password Reset Email Sent',
          'Please check your email for a link to reset your password.');
    } catch (e) {
      isAuthForgotPassLoading.toggle();
      Get.snackbar('Error', 'Failed to send password reset email');
    }
  }

  String? validateName(String value) {
    return ValidationHelper.validateName(value);
  }

  String? validateEmail(String value) {
    return ValidationHelper.validateEmail(value);
  }

  String? validatePassword(String value) {
    return ValidationHelper.validatePassword(value);
  }

  String? validateConfirmPassword(String password, String confirmPassword) {
    return ValidationHelper.validateConfirmPassword(password, confirmPassword);
  }

  void changeColor(int i) {
    if (i == 0) {
      isLeft.value = true;
    } else if (i == 1) {
      isLeft.value = false;
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
