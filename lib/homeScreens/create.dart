import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateAc extends StatefulWidget {
  const CreateAc({super.key});

  @override
  State<CreateAc> createState() => _CreateAcState();
}

class _CreateAcState extends State<CreateAc> {
  TextEditingController confirmPassCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();

  void createAcc() async {
    String email = emailCont.text.trim();
    String password = passCont.text.trim();
    String confirm = confirmPassCont.text.trim();
    if (email == "" || password == "" || confirm == "") {
      log('please fill all details');
    } else if (password != confirm) {
      log("password doesnt match");
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          Navigator.pop(context);
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
        title: Center(child: Text("Register")),
      ),
      body: Column(
        children: [
          TextField(
            controller: emailCont,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                label: Text("Email"), hintText: 'abc@gmail.com'),
          ),
          SizedBox(
            height: 8,
          ),
          TextField(
            controller: passCont,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(label: Text("Password")),
          ),
          SizedBox(
            height: 8,
          ),
          TextField(
            controller: confirmPassCont,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              label: Text("Confirm Password"),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          ElevatedButton(
            onPressed: () {
              createAcc();
              print("working");
            },
            child: Text(
              "Register",
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
