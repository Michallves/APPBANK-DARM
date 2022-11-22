import 'package:appbankdarm/app/view/widgets/cartao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'auth_service.dart';

class CardService extends ChangeNotifier {
  late FirebaseFirestore db = FirebaseFirestore.instance;
  late AuthService auth;

  DocumentSnapshot<Object?>? card;
  String? id;
  String? name;
  String? number;
  String? validity;
  String? flag;
  String? cvc;
  String? type;

  CardService({required this.auth}) {
    readCards();
    readRequestedCards();
  }

  readCards() {
    Stream<QuerySnapshot<Object?>>? data = db
        .collection("users")
        .doc(auth.usuario?.uid)
        .collection('cards')
        .snapshots();
    return data;
  }

  readRequestedCards() {
    Stream<QuerySnapshot<Object?>>? data = db
        .collection("requested_cards")
        .where('idUser', isEqualTo: auth.usuario?.uid)
        .snapshots();
    return data;
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
    await db.collection("users").doc(auth.usuario?.uid).update({
      "cards": FieldValue.increment(1),
    });
  }
}
