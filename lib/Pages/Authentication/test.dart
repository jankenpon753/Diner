// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.fromLTRB(20, 50, 20, 20),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close_rounded),
          ),
          title: Text("Reset Password"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: "Enter new password",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.visibility_off),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: "Re-enter password",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.visibility_off),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: "Re-enter password",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.visibility_off),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: "Re-enter password",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.visibility_off),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: "Re-enter password",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.visibility_off),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: "Re-enter password",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.visibility_off),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: "Re-enter password",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.visibility_off),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: "Re-enter password",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.visibility_off),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                              context: context, builder: (context) => Test());
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
      ),
    );
  }
}
