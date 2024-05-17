// To parse this JSON data, do
//
//     final userRegister = userRegisterFromJson(jsonString);

import 'dart:convert';

UserRegister userRegisterFromJson(String str) =>
    UserRegister.fromJson(json.decode(str));

String userRegisterToJson(UserRegister data) => json.encode(data.toJson());

class UserRegister {
  int? id;
  String? fullname;
  String? email;
  String? address;
  String? password;

  UserRegister({
    this.id,
    required this.fullname,
    required this.email,
    required this.address,
    required this.password,
  });

  factory UserRegister.fromJson(Map<String, dynamic> json) => UserRegister(
        id: json["id"],
        fullname: json["fullname"],
        email: json["email"],
        address: json["address"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "email": email,
        "address": address,
        "password": password,
      };
}
