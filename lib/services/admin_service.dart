import 'package:appbankdarm/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminService extends ChangeNotifier {
  late FirebaseFirestore db = FirebaseFirestore.instance;
  late AuthService auth;

  String? idUser;
  String? name;
  String? number;
  String? flag;
  String? type;
  String? cvc;
  String? validity;

  AdminService({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await readCards();
  }

  readCard(idCard) async {
    await FirebaseFirestore.instance
        .collection('cards_requested')
        .doc(idCard)
        .get()
        .then((doc) {
      name = doc.get('name');
      number = doc.get('number');
      flag = doc.get('flag');
      type = doc.get('type');
      validity = doc.get('validity');
      idUser = doc.get('idUser');
    });
    notifyListeners();
  }

  readCards() {
    Stream<QuerySnapshot<Object?>>? data =
        db.collection("cards_requested").snapshots();
    return data;
  }
}
