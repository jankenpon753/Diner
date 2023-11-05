// ignore_for_file: prefer_const_constructors

import 'package:diner/Pages/Authentication/auth_pages.dart';
import 'package:flutter/material.dart';

class ForgotRecover extends StatefulWidget {
  const ForgotRecover({super.key});

  @override
  State<ForgotRecover> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotRecover> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close_rounded),
          ),
          centerTitle: true,
          title: Text("Recover"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Email",
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Code",
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => ResetPassword());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent[700],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        foregroundColor: Colors.orange[900],
                      ),
                      icon: Icon(
                        Icons.send_outlined,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
