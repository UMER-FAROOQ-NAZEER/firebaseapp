import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticationServices {
  static SignUpPage({
    required BuildContext context,
    required email,
    required password,
    required name,
    required phone,
  }) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseFirestore data = FirebaseFirestore.instance;
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                data.collection("ans").doc(value.user!.uid).set({
                  "uid": value.user!.uid,
                  'name': name,
                  'email': email,
                  "phone": phone,
                  "status": "pending",
                })
              });
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HomePage()));
    } on FirebaseAuthException catch (e) {
      print("error Byme= $e");
    }
  }

  static LoginPage(
      {required context, required email, required password}) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const HomePage(),
      ));
    } catch (e) {}
  }
}
