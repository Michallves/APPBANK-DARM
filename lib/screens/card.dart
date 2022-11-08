import 'package:appbankdarm/services/auth_service.dart';
import 'package:appbankdarm/services/card_service.dart';
import 'package:appbankdarm/utils/app_routes.dart';
import 'package:appbankdarm/widgets/bottom_button.dart';
import 'package:appbankdarm/widgets/cartao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardUser extends StatefulWidget {
  const CardUser({super.key});

  @override
  State<CardUser> createState() => _CardUserState();
}

class _CardUserState extends State<CardUser> {
  bool isLoading = false;
  bool isLoadingButton = false;

  String? name;
  String? number;
  String? flag;
  String? type;
  String? cvc;
  String? validity;

  @override
  void initState() {
    _readCard();
    super.initState();
  }

  _deleteCard() async {
    setState(() {
      isLoadingButton = true;
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(context.read<AuthService>().usuario?.uid)
        .collection('cards')
        .doc(context.read<CardService>().id)
        .delete()
        .then((_) {
      setState(() {
        isLoadingButton = false;
      });
      Navigator.of(context).pushNamed(AppRoutes.HOMEUSER);
    });
  }

  _readCard() async {
    setState(() {
      isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(context.read<AuthService>().usuario?.uid)
        .collection('cards')
        .doc(context.read<CardService>().id!)
        .get()
        .then((doc) {
      setState(() {
        name = doc.get('name');
        number = doc.get('number');
        flag = doc.get('flag');
        type = doc.get('type');
        cvc = doc.get('cvc');
        validity = doc.get('validity');
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(color: Colors.black),
            )
          : Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Cartao(
                    number: number!,
                    flag: flag!,
                    name: name!,
                    validity: validity!,
                    cvc: cvc!,
                    type: type!,
                    obscure: false,
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                BottomButtom(
                  onPress: () => _deleteCard(),
                  title: 'excluir cartão',
                  color: Colors.redAccent,
                  loading: isLoadingButton,
                ),
              ],
            ),
    );
  }
}
