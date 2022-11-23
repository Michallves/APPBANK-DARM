import 'dart:math';

import 'package:appbankdarm/app/providers/user_service.dart';
import 'package:appbankdarm/app/routes/app_routes.dart';
import 'package:appbankdarm/app/view/widgets/bottom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
import '../../../providers/card_service.dart';

class CreateCardValidity extends StatefulWidget {
  const CreateCardValidity({super.key});

  @override
  State<CreateCardValidity> createState() => _CreateCardValidityState();
}

class _CreateCardValidityState extends State<CreateCardValidity> {
  bool isLoading = false;
  String? validity;
  Random random = Random();
  @override
  void initState() {
    super.initState();
    context.read<UserService>().readUser();
  }

  _createNumber() {
    String number;
    String? flag = context.read<CardService>().flag;

    int min = 0;
    int max = 0;
    int restMin = 10000000;
    int restMax = 99999999;

    String randomRest =
        (restMin + random.nextInt(restMax - restMin)).toString();

    try {
      if (flag == "mastercard") {
        min = 51000000;
        max = 55000000;
      } else if (flag == "visa") {
        min = 40000000;
        max = 49999999;
      } else if (flag == "americanexpress") {
        min = 34000000;
        max = 37000000;
      } else if (flag == "hipercard") {
        min = 38410000;
        max = 38410099;
      } else if (flag == "elo") {
        min = 65040500;
        max = 65043999;
      }
    } finally {
      number = ((min + random.nextInt(max - min)).toString() + randomRest);
    }
    return number;
  }

  _createCvc() {
    String cvc;
    cvc = (100 + random.nextInt(999 - 100)).toString();
    return cvc;
  }

  _createCard() async {
    CardService card = context.read<CardService>();
    setState(() => isLoading = true);
    if (context.read<UserService>().user?['cards'] < 6) {
      await FirebaseFirestore.instance
          .collection("requested_cards")
          .add({
            'idUser': context.read<AuthProvider>().usuario?.uid,
            'number': _createNumber(),
            'cvc': _createCvc(),
            'name': card.name,
            'flag': card.flag,
            'validity':
                "${DateTime.now().month.toString().padLeft(2, '0')}/${(DateTime.now().year.toInt() + int.parse(validity!)).toString().substring(2, 4)}",
            'type': card.type,
            'state': 'waiting',
            'justification': '',
          })
          .then((_) =>
              Navigator.of(context).pushReplacementNamed(Routes.HOME_USER))
          .catchError((_) {
            setState(() => isLoading = false);
          });
    } else {
      _showModal();
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
      body: SafeArea(
        child: Column(
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
                enabled: validity != null ? true : false,
                onPress: () => _createCard(),
                title: 'solicitar cartão')
          ],
        ),
      ),
    );
  }

  _showModal() => showModalBottomSheet(
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      context: context,
      builder: (context) => SizedBox(
            height: 300,
            child: Column(children: [
              const Expanded(
                child: Center(
                  child: Text(
                    'Você já possui 6 cartões',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              BottomButtom(
                onPress: () => Navigator.of(context)
                    .pushReplacementNamed(Routes.HOME_USER),
                title: 'Voltar para inicio',
              )
            ]),
          ));
}
