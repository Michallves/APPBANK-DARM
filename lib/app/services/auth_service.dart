import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthService extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseDB = FirebaseFirestore.instance;
  User? usuario;
  final Rxn<User> _firebaseUser = Rxn<User>();

  User? get user => _firebaseUser.value;
  static AuthService get to => Get.find<AuthService>();

  showSnack(String title, String message) {
    Get.snackbar(title, message,
        backgroundColor: Colors.black,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP);
  }

  login({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (erro) {
      showSnack('Erro no login!', erro.message!);
    }
  }

  createUser(
      {required String email,
      required String password,
      required String name,
      required String cpf,
      required String telephone,
      required String accountType,
      required String state,
      required String city,
      required String district,
      required String street,
      required String number}) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((UserCredential userCredential) async {
        await _firebaseDB
            .collection("users")
            .doc(userCredential.user?.uid)
            .set({
          "cpf": cpf,
          'name': name,
          "email": email,
          "telephone": telephone,
          "accountType": accountType,
          "image": '',
          "address": {
            'state': state,
            "city": city,
            "district": district,
            "street": street,
            "number": number,
          },
        });
      });
    } on FirebaseAuthException catch (erro) {
      showSnack('Erro ao registrar!', erro.message!);
    }
  }

  logout() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (erro) {
      showSnack('Erro ao sair!', erro.message!);
    }
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

  passwordReset(email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (erro) {
      showSnack('Erro ao sair!', erro.message!);
    }
  }

  Future deleteAccount() async {
    void deleteUser = await usuario?.delete();
    await _firebaseDB.collection('users').doc(usuario?.uid).delete();
    return deleteUser;
  }

  _getUser() {
    usuario = _firebaseAuth.currentUser;
  }
}
