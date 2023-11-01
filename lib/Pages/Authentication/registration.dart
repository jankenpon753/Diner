// ignore_for_file: prefer_const_constructors
import 'package:diner/Pages/Services/connection.dart';
import 'package:diner/Pages/Services/global.dart';
import 'package:diner/Pages/Services/register_data_model.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(vertical: 70, horizontal: 20),
      child: Scaffold(
          appBar: AppBar(
            title: Text('Register'),
            centerTitle: true,
          ),
          body: Center(
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      TextFormField(
                        autofocus: true,
                        controller: nameController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Name',
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Email Address',
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: userNameController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Username',
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Password',
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: rePasswordController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Enter your password again',
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton.icon(
                          onPressed: () async {
                            if (nameController.text != "" &&
                                emailController.text != "" &&
                                passwordController.text != "" &&
                                userNameController.text != "") {
                              await _checkUser(
                                  nameController.text,
                                  emailController.text,
                                  passwordController.text,
                                  userNameController.text);
                              Navigator.popAndPushNamed(context, '/login');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent[700],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            foregroundColor: Colors.orange[900],
                          ),
                          icon: Icon(
                            Icons.create,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Register',
                            style: TextStyle(color: Colors.white),
                          ))
                    ]),
                  )))),
    );
  }

  Future<void> _checkUser(
      String name, String email, String password, String username) async {
    try {
      var userData = await MongoDB.checkUserData(email);
      if (userData == null) {
        _insertData(name, email, password, username);
      } else {
        final SnackBar snackBar = SnackbarMessage("USER ALREADY EXISTS!");
        snackbarKey.currentState?.showSnackBar(snackBar);
      }
    } catch (e) {
      final SnackBar snackBar = SnackbarMessage("USER ALREADY EXISTS!");
      snackbarKey.currentState?.showSnackBar(snackBar);
    }
  }

  Future<void> _insertData(
      String name, String email, String password, String username) async {
    final data = RegisterDataModel(
      name: name,
      email: email,
      username: username,
      password: password,
      tokens: [],
    );
    await MongoDB.register(data);
    await Future.delayed(const Duration(milliseconds: 1000));
  }
}
