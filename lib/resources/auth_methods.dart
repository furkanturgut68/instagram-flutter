import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:igcloneapp/resources/storage_methods.dart';


class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Sign up
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List fileUrl,
  }) async {
    String res = "Some error occurred!";
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty|| bio.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);

        //Storage to photo
        String photoUrl = await StorageImage().uploadImagetoStorage("profilePics", fileUrl, false);

        print(cred.user!.uid);
        // save to database
          _firestore.collection("users").doc(cred.user!.uid).set({
            'email':email,
            'uid':cred.user!.uid,
            'username':username,
            'bio':bio,
            'followers':[],
            'following':[],
            'photoUrl':photoUrl,
          });

          res = "succes";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //login 
  Future<String> loginUser({ 
    required String emails,
    required String passwords,
  }) async {
      String res = "Some error occurred";
    try {
      if (emails.isNotEmpty || passwords.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: emails, password: passwords);
        res = "succes";

      }else {
        res = "The field error!";
      }
      
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}