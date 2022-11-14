import 'package:appbankdarm/services/auth_service.dart';
import 'package:appbankdarm/services/card_service.dart';
import 'package:appbankdarm/utils/app_routes.dart';
import 'package:appbankdarm/widgets/bottom_button.dart';
import 'package:appbankdarm/widgets/cartao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/user_service.dart';

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
    await FirebaseFirestore.instance
        .collection('users')
        .doc(context.read<AuthService>().usuario?.uid.toString())
        .collection('cards')
        .doc(card?.id)
        .delete()
        .then((_) => Navigator.of(context).pushNamed(AppRoutes.HOME_USER))
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
              obscure: false,
              animation: true,
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          BottomButtom(
            onPress: () => showModal(),
            title: 'excluir cartão',
            color: Colors.redAccent,
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
                          'Tem certeza que deseja excluir o cartão?',
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
