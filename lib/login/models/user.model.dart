import 'package:flutter/cupertino.dart';

class UserModel {
  String name;
  String email;

  //name and email should be mandatory
  UserModel({@required this.name, @required this.email});

  UserModel.empty() {
    name = "";
    email = "";
  }

  Map<String, dynamic> toMap() {
    return {"name": name, "email": email};
  }

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(name: data["name"], email: data["email"]);
  }
}
