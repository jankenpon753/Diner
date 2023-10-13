import 'package:diner/Pages/Services/connection.dart';
import 'package:diner/Pages/Services/user_model.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as Mongo;

class Homepage extends StatefulWidget {
  final Mongo.ObjectId? id;
  const Homepage({super.key, required this.id});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: SafeArea(
          child: SizedBox(
            height: 1000,
            width: 400,
            child: FutureBuilder(
                future: MongoDB.getUserData(widget.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(itemBuilder: (context, index) {
                      var userData = UserModel.fromJson(snapshot.data!);
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.grey.shade700,
                          ),
                          child: Text(userData.tokens[index]),
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
