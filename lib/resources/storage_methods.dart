import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageImage {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future <String> uploadImagetoStorage(String childName, Uint8List file,bool isPost) async{
      Reference ref = _storage.ref().child(childName).child(_auth.currentUser!.uid);
      UploadTask task = ref.putData(file);
      TaskSnapshot snapshot = await task;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
  }
}