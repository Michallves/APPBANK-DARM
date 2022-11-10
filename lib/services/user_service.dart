import 'package:appbankdarm/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserService extends ChangeNotifier {
  late AuthService auth;

  String? name;
  String? image;

  UserService({required this.auth}) {
    readUser();
  }

  readUser() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(auth.usuario?.uid)
        .get()
        .then((doc) {
      addListener(() {
        name = doc.get('name');
        image = doc.get('image');
      });
      notifyListeners();
    });
  }
}
