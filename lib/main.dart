import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasedapk/homeScreens/home.dart';
import 'package:firebasedapk/homeScreens/login.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // QuerySnapshot snapshot =
  // await FirebaseFirestore.instance.collection("user").get();
  // for(var doc in snapshot.docs){
  //   log(doc.data().toString());
  // }
  // Map<String, dynamic> newUserData = {
  //   "Address": "Russia",
  //   "email": "uk@gmail.com",
  //   "name": "Hara"
  // };
  // await FirebaseFirestore.instance.collection("user").add(newUserData);
  // log(" user updated");

  // await FirebaseFirestore.instance
  //     .collection("user")
  //     .doc("97LeePsELB0LhwltRw9c")
  //     .delete();
  // log("user deleted");

  runApp(myapp());
}

class myapp extends StatefulWidget {
  const myapp({super.key});

  @override
  State<myapp> createState() => _myappState();
}

class _myappState extends State<myapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: (FirebaseAuth.instance.currentUser != null) ? Home() : Login(),
      ),
    );
  }
}
