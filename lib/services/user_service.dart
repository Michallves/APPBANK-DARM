import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserService extends ChangeNotifier {
  User? user;
  String? name;
  String? image;

  UserService() {
    readUser();
  }

  readUser() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get()
        .then((doc) {
      name = doc.get('name');
      image = doc.get('image');
      notifyListeners();
    });
  }

  
  FirebaseFirestore db = FirebaseFirestore.instance;

  String? id;
  String? nameCard;
  String? number;
  String? flag;
  String? cvc;
  String? validity;
  String? type;

  createCard(validity) async {
    await db.collection("cards_requested").add({
      'idUser': user!.uid,
      'name': name,
      'flag': flag,
      'validity': validity,
      'type': type,
    });
  }

  registerCard() async {
    await db.collection("users").doc(user?.uid).collection('cards').doc().set({
      'name': name,
      'number': number,
      'flag': flag,
      'cvc': cvc,
      'validity': validity,
    });
  }
}
