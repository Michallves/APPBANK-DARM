import 'package:appbankdarm/databases/db_firestore.dart';
import 'package:appbankdarm/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserRepository extends ChangeNotifier {
  late FirebaseFirestore db;
  late AuthService auth;

  User? user;

  UserRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    _startFirestore();
    _readUser();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  _readUser() async {
    await db.collection("users").doc(auth.usuario?.uid).get().then(
      (DocumentSnapshot doc) {
        return doc.data();
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }
}
