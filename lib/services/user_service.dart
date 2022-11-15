import 'package:appbankdarm/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserService extends ChangeNotifier {
  late AuthService auth;
  DocumentSnapshot<Object?>? user;

  String screen = 'myCards';

  UserService({required this.auth}) {
    readUser();
  }

  readUser() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.usuario?.uid)
        .get()
        .then((doc) {
      addListener(() {
        user = doc;
      });
      notifyListeners();
    });
  }
}
