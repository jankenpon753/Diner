// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
// import 'package:diner/Pages/Services/auth.dart';

import 'package:diner/Pages/Authentication/auth_pages.dart';
import 'package:diner/Pages/Services/connection.dart';
import 'package:diner/Pages/Services/global.dart';
// import 'package:diner/Pages/Services/register_data_model.dart';
import 'package:diner/Pages/Services/user_model.dart';
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
    return Dialog(
      insetPadding: EdgeInsets.symmetric(vertical: 70, horizontal: 20),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text("Sign in or Register"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    autofocus: true,
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
                    ),
                  ),
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
                  Column(
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          // Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (context) => ForgotRecover());
                        },
                        icon: Icon(
                          Icons.question_mark_outlined,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Reset Password',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 30),
                      TextButton.icon(
                        onPressed: () {
                          // Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (context) => Registration());
                        },
                        icon: Icon(
                          Icons.app_registration_outlined,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
