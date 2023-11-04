import 'package:diner/Pages/Services/connection.dart';
import 'package:diner/Pages/Services/user_model.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as Mongo;
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
      appBar: AppBar(title: const Text('Profile')),
      body: Visibility(
        visible: (widget.id == null) ? false : true,
        child: FutureBuilder(
          future: MongoDB.getUserData(widget.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var userData = UserModel.fromJson(snapshot.data!);
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 200,
                          width: 200,
                          child: Image.asset('Assets/Images/meal.png'),
                        ),
                        SizedBox(height: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name'),
                            Text('${userData.name}',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.orangeAccent[700])),
                            SizedBox(height: 16),
                            Text('Email'),
                            Text('${userData.email}',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.orangeAccent[700])),
                          ],
                        ),
                        SizedBox(height: 50),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent[700],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            foregroundColor: Colors.orange[900],
                          ),
                          onPressed: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            // Remove data for the 'counter' key.
                            await prefs.remove('user');
                            Navigator.popAndPushNamed(context, '/');
                          },
                          icon: const Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Logout',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
