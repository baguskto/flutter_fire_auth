import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class FirebaseUserDataSource {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<UserModel>> fetchUsers() {
    return _db.collection('users').snapshots().map((query) =>
        query.docs.map((item) => UserModel.fromJson(item.data())).toList());
  }
}
