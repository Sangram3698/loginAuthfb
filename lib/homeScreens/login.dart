import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasedapk/homeScreens/create.dart';
import 'package:firebasedapk/homeScreens/welcome.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var econt = TextEditingController();
  var pwdcont = TextEditingController();

  void loginFun() async {
    var email = econt.text.toString().trim();
    var password = pwdcont.text.toString().trim();
    if (email == "" || password == "") {
      log("Please fill the options to login");
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Welcome()));
        }
      } on FirebaseAuthException catch (e) {
        log(e.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("login")),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              TextField(
                controller: econt,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.message),
                    label: Text("Email"),
                    hintText: 'abc@gmail.com'),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: pwdcont,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock), label: Text("Password")),
              ),
              SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  loginFun();
                },
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateAc()));
                },
                child: Text(
                  "Create a new account",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
