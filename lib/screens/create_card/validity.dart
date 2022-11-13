import 'dart:math';

import 'package:appbankdarm/utils/app_routes.dart';
import 'package:appbankdarm/widgets/bottom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';
import '../../services/card_service.dart';

class CreateCardValidity extends StatefulWidget {
  const CreateCardValidity({super.key});

  @override
  State<CreateCardValidity> createState() => _CreateCardValidityState();
}

class _CreateCardValidityState extends State<CreateCardValidity> {
  bool isLoading = false;
  String validity = '';
  String? number;
  String? cvc;

  _createNumber() {
    String? flag = context.read<CardService>().flag;
    int min = 5100000000000000;
    int max = 5500000000000000;

    print((min + Random().nextInt(max - min)).toString());
    if (flag == "mastercard") {
      min = 5100000000000000;
      max = 5500000000000000;
      number = (min + Random().nextInt(max - min)).toString();
    } else if (flag == "visa") {
      min = 4000000000000000;
      max = 4999999999999999;
      number = (min + Random().nextInt(max - min)).toString();
    } else if (flag == "americanexpress") {
      min = 3400000000000000;
      max = 3700000000000000;
      number = (min + Random().nextInt(max - min)).toString();
    } else if (flag == "hipercard") {
      min = 3841000000000000;
      max = 3841009999999999;
      number = (min + Random().nextInt(max - min)).toString();
    } else if (flag == "elo") {
      min = 6504050000000000;
      max = 6504399999999999;
      number = (min + Random().nextInt(max - min)).toString();
    }
  }

  _createCard() async {
    CardService card = context.read<CardService>();
    setState(() => isLoading = true);
    try {
      _createNumber();
    } finally {
      await FirebaseFirestore.instance
          .collection("cards_requested")
          .add({
            'idUser': context.read<AuthService>().usuario?.uid,
            'number': number,
            'cvc': Random().nextInt(300).toString().padLeft(3, '0'),
            'name': card.name,
            'flag': card.flag,
            'validity':
                "${DateTime.now().month.toString().padLeft(2, '0')}/${(DateTime.now().year.toInt() + int.parse(validity)).toString().substring(2, 4)}",
            'type': card.type,
            'state': 'waiting'
          })
          .then((_) => Navigator.of(context).pushNamed(AppRoutes.HOME_USER))
          .catchError((_) {
            setState(() => isLoading = false);
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'validade',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    title: const Text('2 anos'),
                    onTap: () => setState(() {
                      validity = '2';
                    }),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    leading: Radio(
                      value: '2',
                      activeColor: Colors.black,
                      groupValue: validity,
                      onChanged: ((String? value) {
                        setState(() {
                          validity = value.toString();
                        });
                      }),
                    ),
                  ),
                  ListTile(
                    title: const Text('4 anos'),
                    onTap: () => setState(() {
                      validity = '4';
                    }),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    leading: Radio(
                      value: '4',
                      activeColor: Colors.black,
                      groupValue: validity,
                      onChanged: ((String? value) {
                        setState(() {
                          validity = value.toString();
                        });
                      }),
                    ),
                  ),
                  ListTile(
                    title: const Text('5 anos'),
                    onTap: () => setState(() {
                      validity = '5';
                    }),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    leading: Radio(
                      value: '5',
                      activeColor: Colors.black,
                      groupValue: validity,
                      onChanged: ((String? value) {
                        setState(() {
                          validity = value.toString();
                        });
                      }),
                    ),
                  ),
                  ListTile(
                    title: const Text('6 anos'),
                    onTap: () => setState(() {
                      validity = '6';
                    }),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    leading: Radio(
                      value: '6',
                      activeColor: Colors.black,
                      groupValue: validity,
                      onChanged: ((String? value) {
                        setState(() {
                          validity = value.toString();
                        });
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
          BottomButtom(
              loading: isLoading,
              enabled: true,
              onPress: () => _createNumber(),
              title: 'solicitar cartão')
        ],
      ),
    );
  }
}
