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
  int currentIndex = 0;
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

  void _onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      Homepage(id: id),
      Shop(),
      MoreMenu()
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.orangeAccent[700],
        selectedLabelStyle: TextStyle(fontSize: 12),
        currentIndex: currentIndex,
        onTap: _onTapped,
        items: [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.more_vert),
              activeIcon: Icon(Icons.more_horiz),
              label: 'Menu'),
        ],
      ),
      body: Center(
        child: widgetOptions.elementAt(currentIndex),
      ),
    );
  }
}
