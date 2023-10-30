// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:diner/Pages/Interface/interface_pages.dart';
import 'package:diner/Pages/Token_Shop/token_shop_pages.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as Mongo;
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 2;
  String? objectid = "";
  Mongo.ObjectId? id;
  void getID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    objectid = prefs.getString('user');
    if (objectid != null) {
      setState(() {
        id = Mongo.ObjectId.fromHexString(objectid!);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getID();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(
            () {
              currentIndex = index;
            },
          );
        },
        elevation: 1,
        selectedIndex: currentIndex,
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.home,
              color: Colors.orangeAccent[700],
            ),
            label: 'Home',
            selectedIcon: Icon(
              Icons.home_outlined,
              color: Colors.orangeAccent[700],
            ),
          ),
          NavigationDestination(
            icon: Icon(
              Icons.shop_2,
              color: Colors.orangeAccent[700],
            ),
            label: 'Shop',
            selectedIcon: Icon(
              Icons.shop_2_outlined,
              color: Colors.orangeAccent[700],
            ),
          ),
          NavigationDestination(
              icon: Icon(
                Icons.more_horiz,
                color: Colors.orangeAccent[700],
              ),
              selectedIcon: Icon(
                Icons.more_horiz_outlined,
                color: Colors.orangeAccent[700],
              ),
              label: 'More'),
        ],
      ),
      body: <Widget>[
        Homepage(
          id: id,
        ),
        BuyToken(),
        MoreMenu()
      ][currentIndex],
    );
  }
}
