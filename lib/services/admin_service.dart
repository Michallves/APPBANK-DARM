import 'package:appbankdarm/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminService extends ChangeNotifier {
  late FirebaseFirestore db = FirebaseFirestore.instance;
  late AuthService auth;

  String? idUser;
  String? idCard;
  String? idUserCard;
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
    await readUsers();
  }

  readCards() {
    Stream<QuerySnapshot<Object?>>? data =
        db.collection("cards_requested").snapshots();
    return data;
  }

  readUsers() {
    Stream<QuerySnapshot<Object?>>? data =
        db.collection("users").where("type", isEqualTo: "user").snapshots();
    return data;
  }
}
