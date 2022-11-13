import 'package:appbankdarm/services/admin_service.dart';
import 'package:appbankdarm/services/card_service.dart';
import 'package:appbankdarm/utils/app_routes.dart';
import 'package:appbankdarm/widgets/bottom_button.dart';
import 'package:appbankdarm/widgets/cartao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardAdmin extends StatefulWidget {
  const CardAdmin({super.key});

  @override
  State<CardAdmin> createState() => _CardAdminState();
}

class _CardAdminState extends State<CardAdmin> {
  bool isLoading = true;
  bool isLoadingButton = false;

  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  _deleteCard() async {
    try {
      await context.read<CardService>().deleteCard();
    } catch (_) {
      setState(() => isLoadingButton = false);
    } finally {
      Navigator.of(context).pushNamed(AppRoutes.HOME_USER);
    }
  }

  _acceptCard() async {
    AdminService card = context.read<AdminService>();
    await db
        .collection('users')
        .doc(context.read<AdminService>().idUserCard)
        .collection('cards')
        .add({
      "name": card.name,
      "number": card.name,
      "flag": card.flag,
      "validity": card.validity,
      "cvc": card.cvc,
      "type": card.type,
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
              number: '00000000000000000',
              flag: context.read<AdminService>().flag!,
              name: context.read<AdminService>().name!,
              validity:
                  '${DateTime.now().month.toString().padLeft(2, '0')}/${(DateTime.now().year.toInt() + int.parse(context.read<AdminService>().validity!)).toString().substring(2, 4)}',
              cvc: null,
              type: context.read<AdminService>().type!,
              obscure: false,
              animation: true,
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          Row(
            children: [
              BottomButtom(
                onPress: () => showModal(),
                title: 'recusar',
                color: Colors.redAccent,
              ),
              BottomButtom(
                onPress: () => _acceptCard(),
                title: 'aceitar',
                color: Colors.greenAccent,
              ),
            ],
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
                        color: Colors.grey[250],
                      )
                    ])
              : const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )));
}
