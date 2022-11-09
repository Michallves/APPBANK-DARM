import 'package:appbankdarm/widgets/cartao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'auth_service.dart';

class CardService extends ChangeNotifier {
  List<Cartao> list = [];
  late FirebaseFirestore db;
  late AuthService auth;
  String? id;
  String? name;
  String? number;
  String? flag;
  String? cvc;
  String? type;

  CardService({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await _readCards();
  }

  _startFirestore() {
    db = FirebaseFirestore.instance;
  }

  _readCards() async {
    if (auth.usuario != null && list.isEmpty) {
      final snapshot = await db
          .collection('users')
          .doc(auth.usuario?.uid)
          .collection('cards')
          .get();
      snapshot.docs.forEach((doc) {
        Cartao card = doc.get('id');
        list.add(card);
        notifyListeners();
      });
    }
  }

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
