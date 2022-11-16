import 'package:appbankdarm/services/card_service.dart';
import 'package:appbankdarm/utils/app_routes.dart';
import 'package:appbankdarm/widgets/bottom_button.dart';
import 'package:appbankdarm/widgets/cartao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class RequestedCard extends StatefulWidget {
  const RequestedCard({super.key});

  @override
  State<RequestedCard> createState() => _RequestedCardState();
}

class _RequestedCardState extends State<RequestedCard> {
  bool isLoading = false;
  bool isLoadingButton = false;
  DocumentSnapshot<Object?>? card;

  @override
  void initState() {
    super.initState();
    card = context.read<CardService>().card;
  }

  _cancelCard() async {
    await FirebaseFirestore.instance
        .collection('requested_cards')
        .doc(card?.id)
        .delete()
        .then((_) =>
            Navigator.of(context).pushReplacementNamed(AppRoutes.HOME_USER))
        .catchError((_) {
      setState(() => isLoadingButton = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Expanded(
              child: Container(
            margin: const EdgeInsets.all(20),
            child: ListView(
              children: [
                const ListTile(
                  title: Text('cartão solicitado'),
                  leading: Icon(
                    MdiIcons.creditCardSyncOutline,
                    size: 30,
                  ),
                  iconColor: Colors.black,
                ),
                Container(
                  height: 20,
                  alignment: Alignment.centerLeft,
                  child: const VerticalDivider(
                    width: 60,
                    thickness: 2,
                    color: Colors.grey,
                  ),
                ),
                const ListTile(
                  title: Text('aguardando avaliação...'),
                  leading: Icon(
                    MdiIcons.creditCardClockOutline,
                    size: 30,
                  ),
                  iconColor: Colors.black,
                ),
                card?['state'] == 'approved'
                    ? Column(children: [
                        Container(
                          height: 20,
                          alignment: Alignment.centerLeft,
                          child: const VerticalDivider(
                            width: 60,
                            thickness: 2,
                            color: Colors.grey,
                          ),
                        ),
                        const ListTile(
                          title: Text('cartão aprovado',
                              style: TextStyle(color: Colors.greenAccent)),
                          leading: Icon(
                            MdiIcons.creditCardCheckOutline,
                            size: 30,
                          ),
                          iconColor: Colors.greenAccent,
                        )
                      ])
                    : Container(),
                card?['state'] == 'recused'
                    ? Column(children: [
                        Container(
                          height: 20,
                          alignment: Alignment.centerLeft,
                          child: const VerticalDivider(
                            width: 60,
                            thickness: 2,
                            color: Colors.grey,
                          ),
                        ),
                        ListTile(
                          title: const Text('cartão recusado',
                              style: TextStyle(color: Colors.redAccent)),
                          subtitle: Text(card?['justification']),
                          leading: const Icon(
                            MdiIcons.creditCardRemoveOutline,
                            size: 30,
                          ),
                          iconColor: Colors.redAccent,
                        ),
                      ])
                    : Container(),
              ],
            ),
          )),
          card?['state'] == 'waiting'
              ? BottomButtom(
                  onPress: () => showModal(),
                  title: 'cancelar solicitação',
                  color: Colors.redAccent,
                )
              : BottomButtom(
                  onPress: () => Navigator.of(context).pop(),
                  title: 'voltar',
                ),
        ],
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
                          'Tem certeza que deseja cancelar a solicitação?',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      )),
                      BottomButtom(
                        onPress: () => _cancelCard(),
                        title: 'cancelar',
                        color: Colors.redAccent,
                      ),
                      BottomButtom(
                        onPress: () => Navigator.of(context).pop(),
                        title: 'agora não',
                        color: Colors.grey[350],
                      )
                    ])
              : const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )));
}
