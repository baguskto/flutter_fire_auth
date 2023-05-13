import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_auth/presentation/navigations/app_routes.dart';
import 'package:get/get.dart';

class AuthController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey1 = GlobalKey<FormState>();
  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signupNameController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController signupConfirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey3 = GlobalKey<FormState>();

  final RxBool obscureTextPassword = true.obs;
  final RxBool obscureTextConfirmPassword = true.obs;

  late PageController pageController;

  Color left = Colors.black;
  Color right = Colors.white;

  RxBool isLeft = true.obs;

  final TextEditingController fpEmailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  void changeColor(int i) {
    if (i == 0) {
      isLeft.value = true;
    } else if (i == 1) {
      isLeft.value = false;
    }
    // if (i == 0) {
    //   right = Colors.white;
    //   left = Colors.black;
    // } else if (i == 1) {
    //   right = Colors.black;
    //   left = Colors.white;
    // }
  }

  Future<void> checkAndUpdateEmailVerification() async {
    User? user = _auth.currentUser;

    if (user != null) {
      await user.reload();
      user = _auth.currentUser;

      bool hasConfirmedEmail = user!.emailVerified;

      // Update the 'hasConfirmedEmail' field in Firestore
      _db
          .collection('users')
          .doc(user.uid)
          .update({'hasConfirmedEmail': hasConfirmedEmail});
    }
  }

  // Registration
  Future<void> registerUser(String name, String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // After successful registration, send email verification
      userCredential.user?.sendEmailVerification();

      // Save additional user details in Firestore
      FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': name,
        'email': email,
        'hasConfirmedEmail': false,
      });
      Get.snackbar('Email Confirmation Sent',
          'Please check your email for a link to confirm your account.');
    } catch (e) {
      Get.snackbar('Failed', e.toString()); // Handle error
    }
  }

  // Login
  Future<void> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // After successful login, check and update email verification status
      await checkAndUpdateEmailVerification();
      Get.toNamed(AppRoutes.HOME);
      // if (!userCredential.user!.emailVerified) {
      //   // Handle not verified email
      // }
    } catch (e) {
      Get.snackbar('Failed', e.toString()); // Handle error
      // Handle error
    }
  }

  // Forgot Password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar('Password Reset Email Sent',
          'Please check your email for a link to reset your password.');
    } catch (e) {
      Get.snackbar('Error', 'Failed to send password reset email');
    }
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return 'Nama tidak boleh kosong';
    } else if (value.length < 3) {
      return 'Nama minimal 3 huruf';
    } else if (value.length > 50) {
      return 'Nama maksimal 50 huruf';
    }
    return null;
  }

  String? validateEmail(String value) {
    // Regex for email validation
    String pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regex = RegExp(pattern);

    if (value.isEmpty) {
      return 'Email tidak boleh kosong';
    } else if (!regex.hasMatch(value)) {
      return 'Masukkan email yang valid';
    }
    return null;
  }

  String? validatePassword(String value) {
    // Regex for password validation: at least one digit, one lowercase, one uppercase
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regex = RegExp(pattern);

    if (value.isEmpty) {
      return 'Password tidak boleh kosong';
    } else if (!regex.hasMatch(value)) {
      return 'Password harus mengandung minimal 8 karakter, angka, huruf besar dan kecil';
    }
    return null;
  }

  String? validateConfirmPassword(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return 'Konfirmasi password tidak boleh kosong';
    } else if (password != confirmPassword) {
      return 'Konfirmasi password harus sama dengan password';
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      Get.offAllNamed(AppRoutes.AUTH);
    } catch (e) {
      Get.snackbar('Error signing out:', e.toString()); // Handle error
    }
  }
}
