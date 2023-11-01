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
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      await mongoDB.getTokenList(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false,
      ),
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
                      child: Center(
                          child: CircularProgressIndicator(
                        color: Colors.orangeAccent[700],
                      )),
                    );
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
                                          size: 250.0,
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
                                  color: Colors.orangeAccent[700],
                                ),
                                child: Center(
                                    child: Text(
                                        '${userData.name} : Token - ${index + 1}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold))),
                              ),
                            ),
                          );
                        });
                  } else {
                    return const Center(
                        child: SizedBox(
                      height: 400,
                      width: 250,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "There seems to be some issues. \n",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            "Please try: \n- Signing in.\nor\n- If you are signed in, check your internet connection.",
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ));
                  }
                }),
          ),
        ),
      ),
    );
  }
}
