import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_auth/presentation/navigations/app_pages.dart';
import 'package:flutter_fire_auth/presentation/navigations/app_routes.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My Auth App',
      initialRoute: AppRoutes.AUTH,
      getPages: AppPages.routes,
    );
  }
}
