import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

// class FirebaseUserDataSource {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//
//   Stream<List<UserModel>> fetchUsers() {
//     return _db.collection('users').snapshots().map((query) =>
//         query.docs.map((item) => UserModel.fromJson(item.data())).toList());
//   }
// }


abstract class UserDataSource {
  Stream<List<UserModel>> fetchUsers();
}

class FirebaseUserDataSource implements UserDataSource {
  final FirebaseFirestore _db;

  FirebaseUserDataSource({required FirebaseFirestore db}) : _db = db;

  @override
  Stream<List<UserModel>> fetchUsers() {
    return _db.collection('users').snapshots().map((query) =>
        query.docs.map((item) => UserModel.fromJson(item.data())).toList());
  }
}
