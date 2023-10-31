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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                  visible: (action == null) ? false : true,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 240,
                          child: Image.asset('Assets/Images/diner.png'),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 0, 204, 255),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              foregroundColor: Colors.orange[900],
                            ),
                            onPressed: () async {
                              print("$id asd");
                              final token =
                                  TokenModel(token: "token", isScanned: false);
                              await MongoDB.tokenRegister(token);
                              try {
                                var tokenData = await MongoDB.getToken();
                                if (tokenData != null) {
                                  var data = TokenGetModel.fromJson(tokenData);
                                  // print(data.id);
                                  var tokenString = data.id!.toHexString();
                                  await MongoDB.changeTokenData(
                                      data.id, tokenString);
                                  await MongoDB.addTokens(id, tokenString);
                                  Dialog tokenDialog = Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            6.0)), //this right here
                                    child: SizedBox(
                                      height: 150.0,
                                      width: 300.0,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Center(
                                            child: Text("Token Number: ",
                                                style: TextStyle(fontSize: 16)),
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          Center(
                                            child: Text(tokenString,
                                                style: TextStyle(fontSize: 16)),
                                          ),
                                          SizedBox(
                                            height: 17,
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Got It!',
                                                  style: TextStyle(
                                                      color: Colors
                                                          .orangeAccent[700],
                                                      fontSize: 20.0)))
                                        ],
                                      ),
                                    ),
                                  );
                                  // ignore: use_build_context_synchronously
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          tokenDialog);
                                } else {
                                  final SnackBar snackBar = SnackbarMessage(
                                      "TypeError: Fields didn't Match!");
                                  snackbarKey.currentState
                                      ?.showSnackBar(snackBar);
                                }
                              } catch (e) {
                                final SnackBar snackBar =
                                    SnackbarMessage("Error: No Data Found!");
                                snackbarKey.currentState
                                    ?.showSnackBar(snackBar);
                              }
                            },
                            child: Text(
                              "Buy Token",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 24),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
