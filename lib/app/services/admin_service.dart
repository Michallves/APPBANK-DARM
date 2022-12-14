import 'package:appbankdarm/app/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

class AdminService extends ChangeNotifier {
  late FirebaseFirestore db = FirebaseFirestore.instance;
  late AuthService auth;
  DocumentSnapshot<Object?>? user;
  DocumentSnapshot<Object?>? card;

  String filter = "name";

  AdminService({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await readUser();
    await readCards();
    await readUsers();
  }

  readUser() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.usuario?.uid)
        .get()
        .then((doc) {
      addListener(() {
        user = doc;
      });
      notifyListeners();
    });
  }

  readCards() {
    Stream<QuerySnapshot<Object?>>? data = db
        .collection("requested_cards")
        .where('state', isEqualTo: 'waiting')
        .snapshots();
    return data;
  }

  readUsers() async {
    List<UserModel> userModelList = [];

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    firestore
        .collection("users")
        .orderBy(filter, descending: filter == 'cards' ? true : false)
        .get()
        .then((user) {
      for (var doc in user.docs) {
        userModelList.add(UserModel.fromJson(doc.data()));
      }
    });
  }
}
