// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(vertical: 70, horizontal: 20),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close_rounded),
          ),
          centerTitle: true,
          title: Text("Reset Password"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    obscureText: passwordVisible,
                    autofocus: true,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Enter new password",
                      suffixIcon: IconButton(
                        icon: Icon(passwordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    obscureText: passwordVisible,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Re-enter password",
                      suffixIcon: IconButton(
                        icon: Icon(passwordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.popAndPushNamed(context, '/login');
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
