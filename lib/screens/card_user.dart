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
  bool isLoading = true;
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
    try {
      context.read<CardService>().deleteCard();
    } catch (_) {
      setState(() => isLoadingButton = false);
    } finally {
      Navigator.of(context).pushNamed(AppRoutes.HOME_USER);
    }
  }

  _readCard() async {
    setState(() {
      isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(context.read<UserService>().auth.usuario?.uid)
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
        isLoading = false;
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
                        color: Colors.grey[250],
                      )
                    ])
              : const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )));
}
