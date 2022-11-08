import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'auth_service.dart';

class CardService extends ChangeNotifier {
  late FirebaseFirestore db = FirebaseFirestore.instance;
  late AuthService auth;
  String? id;
  String? name;
  String? number;
  String? flag;
  String? cvc;
  String? type;

  CardService({required this.auth});

  createCard(validity) async {
    await db.collection("cards_requested").add({
      'idUser': auth.usuario?.uid,
      'name': name,
      'flag': flag,
      'validity': validity,
      'type': type,
    });
  }

  registerCard(validity) async {
    await db
        .collection("users")
        .doc(auth.usuario?.uid)
        .collection('cards')
        .doc()
        .set({
      'name': name,
      'number': number,
      'flag': flag,
      'cvc': cvc,
      'type': '',
      'validity': validity,
    });
  }
}
