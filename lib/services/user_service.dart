import 'package:appbankdarm/services/auth_service.dart';
import 'package:appbankdarm/widgets/cartao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserService extends ChangeNotifier {
  late AuthService auth;
  late String name = 'none';

  late List<Cartao> cards = <Cartao>[
    const Cartao(
        id: '02',
        number: '51561651515116666',
        flag: 'mastercard',
        name: '5',
        validity: '65',
        cvc: '5'),
    const Cartao(
        id: '01',
        number: '515616515151444441',
        flag: 'visa',
        name: '5',
        validity: '65',
        cvc: '5'),
  ];

  UserService({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _readUser();
  }

  _readUser() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(auth.usuario?.uid)
        .get()
        .then((DocumentSnapshot doc) {
      name = doc.get('name');
    });
  }
}
