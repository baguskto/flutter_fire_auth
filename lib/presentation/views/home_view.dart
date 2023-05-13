import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/theme/theme.dart';
import '../controllers/user_controller.dart';

class HomeView extends GetView<UserController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  CustomTheme.loginGradientEnd,
        title: Text('Home'),
        actions: [
          PopupMenuButton<bool>(
            icon: Icon(Icons.filter_alt_rounded),
            onSelected: (value) {
              controller.filterUsers(value);
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: true,
                  child: Text('Verified Users'),
                ),
                PopupMenuItem(
                  value: false,
                  child: Text('Unverified Users'),
                ),
              ];
            },
          ),
          IconButton(
              onPressed: () => controller.authController.signOut(),
              icon: const Icon(Icons.logout_rounded))
        ],
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        if (controller.filteredUsers.isEmpty) {
          return Center(child: Text('No Found User'));
        } else {
          return ListView.builder(
            itemCount: controller.filteredUsers.length,
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(controller.filteredUsers[index].name!),
                subtitle: Text(controller.filteredUsers[index].email!),
                trailing: Text(
                    controller.filteredUsers[index].hasConfirmedEmail!
                        ? 'Verified'
                        : 'Unverified'),
              );
            },
          );
        }
      }),
    );
  }
}
