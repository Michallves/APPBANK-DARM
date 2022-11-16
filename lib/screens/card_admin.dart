import 'package:appbankdarm/services/admin_service.dart';
import 'package:appbankdarm/utils/app_routes.dart';
import 'package:appbankdarm/widgets/bottom_button.dart';
import 'package:appbankdarm/widgets/cartao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/info_card.dart';

class CardAdmin extends StatefulWidget {
  const CardAdmin({super.key});

  @override
  State<CardAdmin> createState() => _CardAdminState();
}

class _CardAdminState extends State<CardAdmin> {
  bool isLoading = false;
  bool isLoadingButton = false;
  final justification = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;
  DocumentSnapshot<Object?>? card;

  @override
  void initState() {
    super.initState();
    card = context.read<AdminService>().card;
  }

  _recusedCard() async {
    setState(() {
      isLoading = true;
    });
    await db.collection('requested_cards').doc(card?.id).update({
      "state": 'recused',
      "justification": justification.text,
    }).then((_) =>
        Navigator.of(context).pushReplacementNamed(AppRoutes.HOME_ADMIN));
  }

  _approvedCard() async {
    setState(() {
      isLoading = true;
    });
    await db.collection('users').doc(card?['idUser']).collection('cards').add({
      "name": card?['name'],
      "number": card?['number'],
      "flag": card?['flag'],
      "validity": card?['validity'],
      "cvc": card?['cvc'],
      "type": card?['type'],
    }).then((_) {
      db.collection("users").doc(card?['idUser']).update({
        "cards": FieldValue.increment(1),
      });
      db.collection('requested_cards').doc(card?.id).update({
        "state": 'approved',
      }).then((_) =>
          Navigator.of(context).pushReplacementNamed(AppRoutes.HOME_ADMIN));
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? const Scaffold(
            body: Center(
                child: CircularProgressIndicator(
            color: Colors.black,
          )))
        : Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Cartao(
                    number: card?['number'],
                    flag: card?['flag'],
                    name: card?['name'],
                    validity: card?['validity'],
                    cvc: card?['cvc'],
                    type: card?['type'],
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
                const Spacer(
                  flex: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: 50,
                        margin: const EdgeInsets.fromLTRB(20, 0, 10, 20),
                        child: ElevatedButton(
                          onPressed: () => showModal(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text('recusar'),
                        )),
                    Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: 50,
                        margin: const EdgeInsets.fromLTRB(10, 0, 20, 20),
                        child: ElevatedButton(
                          onPressed: () => _approvedCard(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.greenAccent,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text('aceitar'),
                        )),
                  ],
                ),
              ],
            ),
          );
  }

  void showModal() => showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      context: context,
      builder: (context) => isLoading == false
          ? Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Expanded(
                            child: Column(
                          children: [
                            const Padding(padding: EdgeInsets.all(10)),
                            const Text(
                              'Tem certeza que deseja recusar o cartão?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Padding(padding: EdgeInsets.all(10)),
                            TextField(
                              maxLength: 160,
                              maxLines: 3,
                              controller: justification,
                              cursorColor: Colors.black,
                              decoration: const InputDecoration(
                                labelText: 'Justificativa',
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                              ),
                            )
                          ],
                        ))),
                    const Padding(padding: EdgeInsets.all(10)),
                    Column(
                      children: [
                        BottomButtom(
                          onPress: () => _recusedCard(),
                          title: 'recusar',
                          color: Colors.redAccent,
                        ),
                        BottomButtom(
                          onPress: () => Navigator.of(context).pop(),
                          title: 'cancelar',
                          color: Colors.grey[350],
                        )
                      ],
                    ),
                  ]))
          : const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            ));
}
