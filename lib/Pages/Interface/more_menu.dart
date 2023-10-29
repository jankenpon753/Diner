// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:diner/Pages/Authentication/auth_pages.dart';
import 'package:diner/Pages/Interface/about.dart';
import 'package:diner/Pages/User/profile.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as Mongo;
import 'package:shared_preferences/shared_preferences.dart';

class MoreMenu extends StatefulWidget {
  const MoreMenu({super.key});

  @override
  State<MoreMenu> createState() => _MoreMenuState();
}

class _MoreMenuState extends State<MoreMenu> {
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

    // print(id);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 25, 20, 30),
            child: Column(
              children: [
                SizedBox(
                  height: 300,
                  width: 400,
                  child: Image.asset('Assets/Images/fried-rice.png'),
                ),
                SizedBox(height: 40),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 400,
                        child: InkWell(
                          onTap: () {
                            if (action == null) {
                              showDialog(
                                context: context,
                                builder: (context) => Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20, 100, 20, 100),
                                  child: Center(child: Login()),
                                ),
                              );
                              // Navigator.pushNamed(context, '/login');
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Profile(
                                          id: (id != null) ? id : null)));
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.person,
                                size: 25,
                                color: Colors.orangeAccent[700],
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Profile',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 400,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/settings');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.settings,
                                size: 25,
                                color: Colors.orangeAccent[700],
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Settings',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 400,
                        child: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 140, 20, 140),
                                      child: Center(child: About()),
                                    ));
                            // Navigator.pushNamed(context, '/about');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.info_outlined,
                                size: 25,
                                color: Colors.orangeAccent[700],
                              ),
                              SizedBox(width: 10),
                              Text(
                                'About Diner',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     IconButton(
                //         onPressed: () {}, icon: Icon(Icons.coffee, size: 40)),
                //     SizedBox(width: 30),
                //     IconButton(
                //       onPressed: () {},
                //       icon: Icon(Icons.perm_contact_cal_sharp, size: 40),
                //     )
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
