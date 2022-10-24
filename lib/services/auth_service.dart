import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../databases/db_firestore.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  bool isLoading = true;

  String? cpf;
  String? name;
  String? email;
  String? telephone;
  List<String>? address;
  String? accountType;
  String? password;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  late FirebaseFirestore db;
  register() async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email!, password: password!)
          .then((UserCredential userCredential) async => {
                db = DBFirestore.get(),
                await db.collection("users").doc(userCredential.user?.uid).set({
                  "cpf": cpf,
                  'name': name,
                  "email": email,
                  " telephone": telephone,
                  "accountType": accountType,
                  "address": {
                    'state': address![0],
                    "city": address![1],
                    "neighborhood": address![2],
                    "street": address![3],
                    "number": address![4],
                  },
                })
              });

      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca!');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este email ja está cadastrado');
      }
    }
  }

  login(String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email!, password: password);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta. Tente novamente');
      }
    }
  }

  logout() async {
    await _auth.signOut();
    _getUser();
  }
}
