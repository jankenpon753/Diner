// To parse this JSON data, do
//
//     final registerDataModel = registerDataModelFromJson(jsonString);

import 'dart:convert';

RegisterDataModel registerDataModelFromJson(String str) =>
    RegisterDataModel.fromJson(json.decode(str));

String registerDataModelToJson(RegisterDataModel data) =>
    json.encode(data.toJson());

class RegisterDataModel {
  String name;
  String email;
  String username;
  String password;
  String tokens;

  RegisterDataModel({
    required this.name,
    required this.email,
    required this.username,
    required this.password,
    required this.tokens,
  });

  factory RegisterDataModel.fromJson(Map<String, dynamic> json) =>
      RegisterDataModel(
        name: json["name"],
        email: json["email"],
        username: json["username"],
        password: json["password"],
        tokens: json["tokens"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "username": username,
        "password": password,
        "tokens": tokens,
      };
}
