// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
// import 'package:diner/Pages/Services/auth.dart';

import 'package:diner/Pages/Authentication/auth_pages.dart';
import 'package:diner/Pages/Interface/home.dart';
import 'package:diner/Pages/Services/connection.dart';
import 'package:diner/Pages/Services/global.dart';
// import 'package:diner/Pages/Services/register_data_model.dart';
import 'package:diner/Pages/Services/user_model.dart';
import 'package:diner/Pages/User/profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final uidController = TextEditingController();
  final passwordController = TextEditingController();
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close_rounded),
          ),
          title: Text("Sign in or Register"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextFormField(
              controller: uidController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Username or Email',
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
                controller: passwordController,
                obscureText: passwordVisible,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: "Password",
                  suffixIcon: IconButton(
                    icon: Icon(passwordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined),
                    onPressed: () {
                      setState(
                        () {
                          passwordVisible = !passwordVisible;
                        },
                      );
                    },
                  ),
                )),
            SizedBox(height: 10),
            ElevatedButton.icon(
                onPressed: () async {
                  _logIn(uidController.text, passwordController.text);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent[700],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  foregroundColor: Colors.orange[900],
                ),
                icon: Icon(
                  Icons.login_sharp,
                  color: Colors.white,
                  size: 20,
                ),
                label: Text('Login',
                    style: TextStyle(color: Colors.white, fontSize: 17))),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                    onPressed: () {
                      // Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (context) => Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 140, 20, 140),
                                child: Center(child: ForgotMail()),
                              ));
                    },
                    icon: Icon(
                      Icons.question_mark_outlined,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Forgot password',
                      style: TextStyle(color: Colors.white),
                    )),
                SizedBox(width: 30),
                TextButton.icon(
                    onPressed: () {
                      // Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (context) => Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 140, 20, 140),
                                child: Center(child: Registration()),
                              ));
                    },
                    icon: Icon(
                      Icons.app_registration_outlined,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
          ]),
        ));
  }

  Future<void> _logIn(String username, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var userData = await MongoDB.logIn(username, password);
      if (userData != null) {
        var user = UserModel.fromJson(userData);
        print(user.id);
        await prefs.setString('user', user.id!.toHexString());
        print(prefs.getString('user'));
        Navigator.popAndPushNamed(context, '/');
        // Navigator.of(context).pop();
        // ignore: use_build_context_synchronously
        // showDialog(
        //     context: context,
        //     builder: (context) => Padding(
        //           padding: const EdgeInsets.fromLTRB(20, 140, 20, 140),
        //           child: Center(child: Text("You are Logged in.")),
        //         ));
      } else {
        final SnackBar snackBar =
            SnackbarMessage("TypeError: Fields didn't Match!");
        snackbarKey.currentState?.showSnackBar(snackBar);
      }
    } catch (e) {
      final SnackBar snackBar = SnackbarMessage("Error: No Data Found!");
      snackbarKey.currentState?.showSnackBar(snackBar);
    }
  }
}
