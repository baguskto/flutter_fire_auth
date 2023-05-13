class UserModel {
  String? id;
  String? name;
  String? email;
  bool? hasConfirmedEmail;

  UserModel({this.id, this.name, this.email, this.hasConfirmedEmail});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    hasConfirmedEmail = json['hasConfirmedEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['hasConfirmedEmail'] = hasConfirmedEmail;
    return data;
  }
}
