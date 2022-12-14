import 'package:appbankdarm/app/services/auth_service.dart';
import 'package:appbankdarm/app/services/card_service.dart';
import 'package:appbankdarm/app/routes/app_routes.dart';
import 'package:appbankdarm/app/view/widgets/bottom_button.dart';
import 'package:appbankdarm/app/view/widgets/cartao.dart';
import 'package:appbankdarm/app/view/widgets/info_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/card_model.dart';

class CardUser extends StatefulWidget {
  const CardUser({super.key});

  @override
  State<CardUser> createState() => _CardUserState();
}

class _CardUserState extends State<CardUser> {
  bool isLoading = false;
  bool isLoadingButton = false;
  DocumentSnapshot<Object?>? card;

  @override
  void initState() {
    super.initState();
    card = context.read<CardService>().card;
  }

  _deleteCard() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db
        .collection('users')
        .doc(context.read<AuthService>().usuario?.uid)
        .collection('cards')
        .doc(card?.id)
        .delete()
        .then((_) => db
                .collection("users")
                .doc(context.read<AuthService>().usuario?.uid)
                .update({
              "cards": FieldValue.increment(-1),
            }).then((_) => Navigator.of(context).pushNamed(Routes.HOME_USER)))
        .catchError((_) {
      setState(() => isLoadingButton = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: CartaoCard(
                        Cartao(
                          number: card?['number'],
                          flag: card?['flag'],
                          name: card?['name'],
                          validity: card?['validity'],
                          cvc: card?['cvc'],
                          type: card?['type'],
                        ),
                        obscure: false,
                        animation: true,
                      ),
                    ),
                    InfoCard(
                      name: card?['name'],
                      number: card?['number'],
                      validity: card?['validity'],
                      cvc: card?['cvc'],
                      flag: card?['flag'],
                      type: card?['type'],
                    ),
                  ],
                ),
              ),
            ),
            BottomButtom(
              onPress: () => showModal(),
              title: 'excluir cart??o',
              color: Colors.redAccent,
            ),
          ],
        ),
      ),
    );
  }

  void showModal() => showModalBottomSheet(
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      context: context,
      builder: (context) => SizedBox(
          height: 250,
          child: isLoading == false
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                      const Expanded(
                          child: Center(
                        child: Text(
                          'Tem certeza que deseja excluir o cart??o?',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      )),
                      BottomButtom(
                        onPress: () => _deleteCard(),
                        title: 'excluir',
                        color: Colors.redAccent,
                      ),
                      BottomButtom(
                        onPress: () => Navigator.of(context).pop(),
                        title: 'cancelar',
                        color: Colors.grey[350],
                      )
                    ])
              : const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )));
}
