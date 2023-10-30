import 'dart:async';

import 'package:diner/Pages/Services/connection.dart';
import 'package:diner/Pages/Services/user_model.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as Mongo;
import 'package:qr_flutter/qr_flutter.dart';

class Homepage extends StatefulWidget {
  final Mongo.ObjectId? id;
  const Homepage({super.key, required this.id});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  MongoDB mongoDB = MongoDB();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(const Duration(seconds: 4), (timer) async {
      await mongoDB.getTokenList(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: SafeArea(
          child: SizedBox(
            height: double.infinity,
            width: 400,
            child: StreamBuilder(
                stream: mongoDB.tokenController.stream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                        height: 40,
                        width: 40,
                        child: Center(child: CircularProgressIndicator()));
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount:
                            UserModel.fromJson(snapshot.data!).tokens.length,
                        itemBuilder: (context, index) {
                          var userData = UserModel.fromJson(snapshot.data!);
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: GestureDetector(
                              onTap: () {
                                Dialog tokenDialog = Dialog(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          12.0)), //this right here
                                  child: Container(
                                    height: 300.0,
                                    width: 300.0,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        QrImageView(
                                          data: '${userData.tokens[index]}',
                                          version: QrVersions.auto,
                                          size: 200.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        tokenDialog);
                              },
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.grey.shade700,
                                ),
                                child: Center(
                                    child: Text(
                                        '${userData.name} : Token - ${index + 1}')),
                              ),
                            ),
                          );
                        });
                  } else {
                    return SizedBox();
                  }
                }),
          ),
        ),
      ),
    );
  }
}
