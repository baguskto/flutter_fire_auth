import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../data/data_source/firebase_auth_data_source.dart';
import '../../data/data_source/firebase_user_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/firebase_user_database_repository.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/user_database_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/usecases/check_and_update_email_verification_usecase.dart';
import '../../domain/usecases/create_user_usecase.dart';
import '../../domain/usecases/fetch_users_usecase.dart';
import '../../domain/usecases/filter_users_usecase.dart';
import '../../domain/usecases/login_use_usecase.dart';
import '../../domain/usecases/register_user_usescase.dart';
import '../../domain/usecases/send_password_reset_email_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import '../controllers/auth_controller.dart';
import '../controllers/user_controller.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirebaseAuth>(() => FirebaseAuth.instance);
    Get.lazyPut<FirebaseFirestore>(() => FirebaseFirestore.instance);
    Get.lazyPut<FirebaseAuthDataSource>(
        () => FirebaseAuthDataSource(auth: Get.find<FirebaseAuth>()));
    Get.lazyPut<AuthRepository>(() => FirebaseAuthRepository(
        Get.find<FirebaseAuthDataSource>(),
        Get.find<UserDatabaseRepository>()));
    Get.lazyPut<UserDatabaseRepository>(
        () => FirebaseUserDatabaseRepository(Get.find<FirebaseFirestore>()));

    Get.lazyPut<RegisterUserUseCase>(
        () => RegisterUserUseCase(Get.find<AuthRepository>()));
    Get.lazyPut<LoginUserUseCase>(
        () => LoginUserUseCase(Get.find<AuthRepository>()));
    Get.lazyPut<SendPasswordResetEmailUseCase>(
        () => SendPasswordResetEmailUseCase(Get.find<AuthRepository>()));
    Get.lazyPut<SignOutUseCase>(
        () => SignOutUseCase(Get.find<AuthRepository>()));
    Get.lazyPut<CheckAndUpdateEmailVerificationUseCase>(() =>
        CheckAndUpdateEmailVerificationUseCase(Get.find<AuthRepository>()));
    Get.lazyPut<CreateUserUseCase>(
        () => CreateUserUseCase(Get.find<UserDatabaseRepository>()));

    Get.lazyPut<AuthController>(() => AuthController(
          Get.find<RegisterUserUseCase>(),
          Get.find<LoginUserUseCase>(),
          Get.find<SendPasswordResetEmailUseCase>(),
          Get.find<CheckAndUpdateEmailVerificationUseCase>(),
          Get.find<CreateUserUseCase>(),
        ));

    Get.lazyPut<FirebaseUserDataSource>(() => FirebaseUserDataSource(db: FirebaseFirestore.instance));
    Get.lazyPut<UserRepository>(
        () => UserRepositoryImpl(Get.find<FirebaseUserDataSource>()));
    Get.lazyPut<FetchUsersUseCase>(
        () => FetchUsersUseCase(Get.find<UserRepository>()));
    Get.lazyPut<FilterUsersUseCase>(() => FilterUsersUseCase());
    Get.lazyPut<UserController>(() => UserController(
          Get.find<FetchUsersUseCase>(),
          Get.find<FilterUsersUseCase>(),
          Get.find<SignOutUseCase>(),
          Get.find<CheckAndUpdateEmailVerificationUseCase>(),
        ));
  }
}
