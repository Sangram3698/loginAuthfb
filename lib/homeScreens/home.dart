import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasedapk/homeScreens/login.dart';
import 'package:firebasedapk/homeScreens/success.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var idCont = TextEditingController();
  var nameCont = TextEditingController();
  var emailCont = TextEditingController();
  var addressCont = TextEditingController();

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  void adding() async {
    var id = idCont.text.toString().trim();
    var name = nameCont.text.toString().trim();
    var email = emailCont.text.toString().trim();
    var address = addressCont.text.toString().trim();

    Map<String, dynamic> newUserData = {
      "name": name,
      "email": email,
      "address": address
    };
    if (id == "" || name == "" || email == "" || address == "") {
      log("Please fill all the areas properly");
    } else {
      await FirebaseFirestore.instance
          .collection("user")
          .doc('$id')
          .set(newUserData);
      log("user added successfully");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Success()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                logout();
              },
              icon: Icon(Icons.logout))
        ],
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "Home",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: SafeArea(
          top: true,
          child: Column(
            children: [
              TextFormField(
                controller: idCont,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  label: Text("Id"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: nameCont,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  label: Text("Name"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: emailCont,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  label: Text("email"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: addressCont,
                decoration: InputDecoration(
                  label: Text("Address"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    adding();
                  },
                  child: Text(
                    "Add",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
                  ))
            ],
          )),
    );
  }
}
