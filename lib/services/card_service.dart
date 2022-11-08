import 'package:appbankdarm/services/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CardService extends ChangeNotifier {
  late FirebaseFirestore db = FirebaseFirestore.instance;

  late UserService user;
  String? id;
  String? name;
  String? number;
  String? flag;
  String? cvc;
  String? type;

  CardService({required this.user});

  createCard(validity) async {
    await db.collection("cards_requested").add({
      'idUser': user.user?.uid,
      'name': name,
      'flag': flag,
      'validity': validity,
      'type': type,
    });
  }

  registerCard(validity) async {
    await db
        .collection("users")
        .doc(user.user?.uid)
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
