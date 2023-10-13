import 'package:diner/Pages/Services/connection.dart';
import 'package:diner/Pages/Services/user_model.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as Mongo;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  final Mongo.ObjectId? id;
  const Profile({super.key, required this.id});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Visibility(
        visible: (widget.id == null) ? false : true,
        child: FutureBuilder(
            future: MongoDB.getUserData(widget.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var userData = UserModel.fromJson(snapshot.data!);
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Name: ${userData.name}'),
                            SizedBox(
                              height: 16,
                            ),
                            Text('Email: ${userData.email}'),
                            SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            TextButton.icon(
                                onPressed: () async {
                                  final SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  // Remove data for the 'counter' key.
                                  await prefs.remove('user');
                                  Navigator.pushReplacementNamed(context, '/');
                                },
                                icon: Icon(Icons.logout),
                                label: Text('Logout'))
                          ]),
                    ],
                  ),
                );
              } else {
                return SizedBox();
              }
            }),
      ),
    );
  }
}
