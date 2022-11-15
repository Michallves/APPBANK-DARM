import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
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
    _getUser();
  }

  Future login(String password) async {
    UserCredential userAuth = await _auth.signInWithEmailAndPassword(
        email: email!, password: password);
    _getUser();
    return userAuth;
  }

  Future register(passwordConfirm) async {
    UserCredential userAuth = await _auth.createUserWithEmailAndPassword(
      email: email!,
      password: passwordConfirm,
    );
    await db.collection("users").doc(userAuth.user?.uid).set({
      "cpf": cpf,
      'name': name,
      "email": email,
      "telephone": telephone,
      if (rool == 'user') "accountType": accountType,
      "image": '',
      "rool": rool,
      'state': address![0],
      "address": {
        "city": address![1],
        "neighborhood": address![2],
        "street": address![3],
        "number": address![4],
      },
      "cards": 0,
    });
    _getUser();
    return userAuth;
  }

  Future logout() async {
    void logout = await _auth.signOut();
    _getUser();
    return logout;
  }

  Future reAuth(String password) async {
    UserCredential reAuth = await usuario!.reauthenticateWithCredential(
        EmailAuthProvider.credential(
            email: usuario!.email!, password: password));
    _getUser();
    return reAuth;
  }

  Future updatePassword(String password) async {
    return await usuario?.updatePassword(password);
  }

  Future deleteAccount() async {
    void deleteUser = await usuario?.delete();
    await db.collection('users').doc(usuario?.uid).delete();
    return deleteUser;
  }

  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }
}
