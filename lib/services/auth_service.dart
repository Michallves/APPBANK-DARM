import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;

  String? cpf;
  String? name;
  String? email;
  String? telephone;
  List<String>? address;
  String? accountType;
  String? password;
  String? type;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      notifyListeners();
    });
  }

  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  login(String password) async {
    _auth.signInWithEmailAndPassword(email: email!, password: password);
    _getUser();
  }

  register(String password, String type) async {
    await _auth
        .createUserWithEmailAndPassword(
          email: email!,
          password: password,
        )
        .then((UserCredential userCredential) async => {
              await FirebaseFirestore.instance
                  .collection("users")
                  .doc(userCredential.user?.uid)
                  .set({
                "cpf": cpf,
                'name': name,
                "email": email,
                "telephone": telephone,
                "accountType": accountType,
                "type": type,
                "address": {
                  'state': address![0],
                  "city": address![1],
                  "neighborhood": address![2],
                  "street": address![3],
                  "number": address![4],
                },
              }),
            });
    _getUser();
  }

  logout() async {
    await _auth.signOut();
    _getUser();
  }
}
