// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:io';

import 'package:diner/Pages/Services/global.dart';
import 'package:diner/Pages/Services/register_data_model.dart';
import 'package:diner/Pages/Services/token_model.dart';
import 'package:diner/Pages/Services/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDB {
  StreamController profileController = StreamController();
  StreamController tokenController = StreamController();

  static var dataBase;
  static connect() async {
    try {
      dataBase = await Db.create(
          "mongodb+srv://jankenpon753:tajim2511@cluster0.x9v9ghb.mongodb.net/Diner");
      await dataBase.open(secure: true);
      // inspect(db);
    } on SocketException {
      final SnackBar snackBar = SnackbarMessage("No Internet Connection!");
      snackbarKey.currentState?.showSnackBar(snackBar);
    } on TimeoutException {
      return;
    } on ConnectionException {
      final SnackBar snackBar =
          SnackbarMessage("Network Failure: IO Exception!");
      snackbarKey.currentState?.showSnackBar(snackBar);
    } on ClientException {
      final SnackBar snackBar = SnackbarMessage("CAN'T FIND CLIENT!");
      snackbarKey.currentState?.showSnackBar(snackBar);
    } on HttpException {
      return;
    } on HandshakeException {
      return;
    }
  }

  // Register Model

  static Future<void> register(RegisterDataModel data) async {
    try {
      await dataBase.collection('RegisterUser').insertOne(data.toJson());
    } catch (e) {
      return;
    }
  }

  static Future<void> tokenRegister(TokenModel data) async {
    try {
      await dataBase.collection('Token').insertOne(data.toJson());
    } catch (e) {
      return;
    }
  }

  static Future<Map<String, dynamic>?> getToken() async {
    try {
      final tokenData =
          await dataBase.collection('Token').findOne({"token": "token"});
      return tokenData;
    } catch (e) {
      return null;
    }
  }

  static Future<void> changeTokenData(ObjectId? id, String value) async {
    try {
      await dataBase
          .collection('Token')
          .updateOne({"_id": id}, modify.set("token", value));
    } catch (e) {
      return;
    }
  }

  static Future<void> changeUserToken(ObjectId? id, String value) async {
    try {
      await dataBase
          .collection('RegisterUser')
          .updateOne({"_id": id}, modify.set("tokens", value));
    } catch (e) {
      return;
    }
  }

  static Future<Map<String, dynamic>?> logIn(
      String username, String password) async {
    try {
      final data = await dataBase
          .collection('RegisterUser')
          .findOne({"username": username, "password": password});
      if (data == null) {
        try {
          final data = await dataBase
              .collection('RegisterUser')
              .findOne({"email": username, "password": password});
          return data;
        } catch (e) {
          return null;
        }
      }
      return data;
    } catch (e) {
      return null;
    }
  }

  static Future<void> addTokens(ObjectId? id, String token) async {
    try {
      await dataBase
          .collection('RegisterUser')
          .updateOne({"_id": id}, modify.addToSet('tokens', token));
    } catch (e) {
      return;
    }
  }

  static Future<Map<String, dynamic>?> getUserData(ObjectId? id) async {
    try {
      final userData =
          await dataBase.collection('RegisterUser').findOne({"_id": id});
      return userData;
    } catch (e) {
      return null;
    }
  }

  Future<void> getTokenList(ObjectId? id) async {
    try {
      final userData =
          await dataBase.collection('RegisterUser').findOne({"_id": id});
      tokenController.sink.add(userData);
    } catch (e) {
      return;
    }
  }

  static Future<Map<String, dynamic>?> checkUserData(String number) async {
    try {
      var data =
          await dataBase.collection('Register').findOne({"number": number});
      return data;
    } catch (e) {
      return null;
    }
  }

  static Future<void> forgetPassword(String number, String value) async {
    try {
      await dataBase
          .collection('Register')
          .updateOne({"number": number}, modify.set("password", value));
    } catch (e) {
      return;
    }
  }

  static Future<void> changePassword(ObjectId? id, String value) async {
    try {
      await dataBase
          .collection('Register')
          .updateOne({"_id": id}, modify.set("password", value));
    } catch (e) {
      return;
    }
  }

  static Future<void> deleteUser(ObjectId? id) async {
    try {
      await dataBase.collection('Register').remove({"_id": id});
    } catch (e) {
      return;
    }
  }
}
