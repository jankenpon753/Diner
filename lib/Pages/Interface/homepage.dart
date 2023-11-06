import 'dart:async';

import 'package:diner/Pages/Services/connection.dart';
import 'package:diner/Pages/Services/user_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mongo_dart/mongo_dart.dart' as Mongo;
import 'package:qr_flutter/qr_flutter.dart';

class Homepage extends StatefulWidget {
  final Mongo.ObjectId? id;
  const Homepage({super.key, required this.id});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var userType = true;
  MongoDB mongoDB = MongoDB();

  void getData() async {
    userType = await MongoDB.getRole(widget.id);
    setState(() {});
  }

  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
    Timer.periodic(const Duration(seconds: 4), (timer) async {
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
            width: 350,
            child: StreamBuilder(
              stream: mongoDB.tokenController.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: 40,
                    width: 40,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: (!userType),
                            child: const SizedBox(
                              child: Text(
                                "This page hasn't been implemented for seller side.",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: (userType),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // CircularProgressIndicator(
                                //   color: Colors.orangeAccent[700],
                                // ),
                                SizedBox(
                                    height: 100,
                                    child: Lottie.asset(
                                        'Assets/Images/loading.json')),
                                const SizedBox(height: 15),
                                const SizedBox(child: Text("Fetching Data..."))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: UserModel.fromJson(snapshot.data!).tokens.length,
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
                              child: SizedBox(
                                height: 290.0,
                                width: 290.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    QrImageView(
                                      data: '${userData.tokens[index]}',
                                      version: QrVersions.auto,
                                      size: 255.0,
                                    ),
                                  ],
                                ),
                              ),
                            );
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => tokenDialog);
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.orangeAccent[700],
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 35,
                                        // child: Image.asset(
                                        //     'Assets/Images/foods.json'),
                                        child: Lottie.asset(
                                            'Assets/Images/foods.json'),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        '${userData.name} : Token - ${index + 1}',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
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
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
