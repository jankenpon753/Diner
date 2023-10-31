// ignore_for_file: prefer_const_constructors

import 'package:diner/Pages/Services/connection.dart';
import 'package:diner/Pages/Services/global.dart';
import 'package:diner/Pages/Services/token_get_model.dart';
import 'package:diner/Pages/Services/token_model.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as Mongo;
import 'package:shared_preferences/shared_preferences.dart';

class SellToken extends StatefulWidget {
  const SellToken({super.key});

  @override
  State<SellToken> createState() => _BuyTokenState();
}

class _BuyTokenState extends State<SellToken> {
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
      appBar: AppBar(title: Text('Sell')),
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
                            onPressed: () {},
                            child: Text(
                              "Scan Token",
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
