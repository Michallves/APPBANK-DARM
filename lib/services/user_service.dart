import 'package:appbankdarm/services/auth_service.dart';
import 'package:appbankdarm/widgets/cartao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserService extends ChangeNotifier {
  late User user;
  late String name = 'none';
  late dynamic userData;

  late List<Cartao> cards = <Cartao>[];

  readUser() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot doc) {
      Object? data = doc.data();
      userData = data;
    });
  }
}
