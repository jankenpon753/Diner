// To parse this JSON data, do
//
//     final tokenGetModel = tokenGetModelFromJson(jsonString);

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

TokenGetModel tokenGetModelFromJson(String str) =>
    TokenGetModel.fromJson(json.decode(str));

String tokenGetModelToJson(TokenGetModel data) => json.encode(data.toJson());

class TokenGetModel {
  ObjectId? id;
  String token;
  bool isScanned;

  TokenGetModel({
    required this.id,
    required this.token,
    required this.isScanned,
  });

  factory TokenGetModel.fromJson(Map<String, dynamic> json) => TokenGetModel(
        id: json["_id"],
        token: json["token"],
        isScanned: json["isScanned"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "token": token,
        "isScanned": isScanned,
      };
}
