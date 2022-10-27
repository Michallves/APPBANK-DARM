import 'package:appbankdarm/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserService extends ChangeNotifier {
  late AuthService auth;
  late String name;

  UserService({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    _readUser();
  }

  _readUser() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(auth.usuario?.uid)
        .get()
        .then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
    });
  }
}
