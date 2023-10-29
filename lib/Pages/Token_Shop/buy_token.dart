// ignore_for_file: prefer_const_constructors

import 'package:diner/Pages/Services/connection.dart';
import 'package:diner/Pages/Services/global.dart';
import 'package:diner/Pages/Services/token_get_model.dart';
import 'package:diner/Pages/Services/token_model.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as Mongo;
import 'package:shared_preferences/shared_preferences.dart';

class BuyToken extends StatefulWidget {
  const BuyToken({super.key});

  @override
  State<BuyToken> createState() => _BuyTokenState();
}

class _BuyTokenState extends State<BuyToken> {
  String? action = "";
  Mongo.ObjectId? id;
  void getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // TODO: implement initState
    setState(() {
      action = prefs.getString('user');
      if (action != null) {
        id = Mongo.ObjectId.fromHexString(action!);
      }
    });
    print(id);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }
  // Obtain shared preferences.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shop')),
      body: Center(
        child: SafeArea(
          child: SizedBox(
            height: 1000,
            width: 400,
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Divider(color: Colors.white),
                    Visibility(
                      visible: (action == null) ? false : true,
                      child: GestureDetector(
                        onTap: () async {
                          final token =
                              TokenModel(token: "token", isScanned: false);
                          await MongoDB.tokenRegister(token);
                          try {
                            var tokenData = await MongoDB.getToken();
                            if (tokenData != null) {
                              var data = TokenGetModel.fromJson(tokenData);
                              print(data.id);
                              var tokenString = data.id!.toHexString();
                              await MongoDB.changeTokenData(
                                  data.id, tokenString);
                              await MongoDB.addTokens(id, tokenString);
                              Dialog tokenDialog = Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        12.0)), //this right here
                                child: Container(
                                  height: 200.0,
                                  width: 300.0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Center(
                                        child: Text("Token Number: "),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Center(
                                        child: Text(tokenString),
                                      ),
                                      SizedBox(
                                        height: 32,
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Got It!',
                                            style: TextStyle(
                                                color: Colors.purple,
                                                fontSize: 18.0),
                                          ))
                                    ],
                                  ),
                                ),
                              );
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      tokenDialog);
                            } else {
                              final SnackBar snackBar = SnackbarMessage(
                                  "TypeError: Fields didn't Match!");
                              snackbarKey.currentState?.showSnackBar(snackBar);
                            }
                          } catch (e) {
                            final SnackBar snackBar =
                                SnackbarMessage("Error: No Data Found!");
                            snackbarKey.currentState?.showSnackBar(snackBar);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 300,
                                width: 400,
                                child:
                                    Image.asset('Assets/Images/fried-rice.png'),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.teal),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: Center(
                                      child: Text("Buy Token",
                                          style: TextStyle(fontSize: 24))),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(color: Colors.white),
                    SizedBox(
                      height: 250,
                      width: 400,
                      child: InkWell(
                        onTap: () {
                          // Navigator.pushNamed(context, ');
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
