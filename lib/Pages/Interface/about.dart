// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(vertical: 200, horizontal: 20),
      child: Scaffold(
        appBar: AppBar(
          title: Text('About'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.asset('Assets/Images/diner.png'),
          ),
        ),
      ),
    );
  }
}
