import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Sign up
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    //required Uint8List file,
  }) async {
    String res = "Some error occurred!";
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty|| bio.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);

        //print(cred.user!.uid);
        // save to database
          _firestore.collection("users").doc(cred.user!.uid).set({
            'email':email,
            'uid':cred.user!.uid,
            'username':username,
            'bio':bio,
            'followers':[],
            'following':[],
          });

          //  _firestore.collection("users").doc(cred.user!.uid).set({
          //   'email':email,
          //   'uid':cred.user!.uid,
          //   'username':username,
          //   'bio':bio,
          //   'followers':[],
          //   'following':[],
          // });

          res = "succes";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}