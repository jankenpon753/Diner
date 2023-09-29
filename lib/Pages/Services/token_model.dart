// To parse this JSON data, do
//
//     final tokenModel = tokenModelFromJson(jsonString);

import 'dart:convert';

TokenModel tokenModelFromJson(String str) =>
    TokenModel.fromJson(json.decode(str));

String tokenModelToJson(TokenModel data) => json.encode(data.toJson());

class TokenModel {
  String token;
  bool isScanned;

  TokenModel({
    required this.token,
    required this.isScanned,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        token: json["token"],
        isScanned: json["isScanned"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "isScanned": isScanned,
      };
}
