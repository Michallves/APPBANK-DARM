import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserService extends ChangeNotifier {
  User? user;
  UserService({required this.user});

  String? name;
  String? image;

  readUser() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get()
        .then((doc) {
      addListener(() {
        name = doc.get('name');
        image = doc.get('image');
      });
    
    });
    notifyListeners();
  }
}
