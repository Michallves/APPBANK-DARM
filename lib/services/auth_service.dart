import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  User? usuario;

  String rool = 'user';
  String? cpf;
  String? name;
  String? email;
  String? telephone;
  List<String>? address;
  String? accountType;
  String? password;
  String? type;

  AuthService() {
    getUser();
  }

  getUser() {
    usuario = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }
}
