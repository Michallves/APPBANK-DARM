import 'package:appbankdarm/services/admin_service.dart';
import 'package:appbankdarm/services/card_service.dart';
import 'package:appbankdarm/utils/app_routes.dart';
import 'package:appbankdarm/widgets/bottom_button.dart';
import 'package:appbankdarm/widgets/cartao.dart';
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

  @override
  void initState() {
    _readCard();
    super.initState();
  }

  _readCard() async {
    try {
      await context
          .read<AdminService>()
          .readCard(ModalRoute.of(context)!.settings.arguments);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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
                    number: '00000000000000000',
                    flag: 'flag!',
                    name: context.read<AdminService>().name.toString(),
                    validity: 'validity!',
                    cvc: null,
                    type: 'type!',
                    obscure: false,
                    animation: false,
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
