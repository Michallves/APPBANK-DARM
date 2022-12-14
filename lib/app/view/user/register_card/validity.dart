import 'package:appbankdarm/app/routes/app_routes.dart';
import 'package:credit_card_validator/credit_card_validator.dart';

import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../services/card_service.dart';
import '../../../services/user_service.dart';
import '../../widgets/bottom_button.dart';

class RegisterCardValidity extends StatefulWidget {
  const RegisterCardValidity({super.key});

  @override
  State<RegisterCardValidity> createState() => _RegisterCardValidityState();
}

class _RegisterCardValidityState extends State<RegisterCardValidity> {
  bool isButtonActive = false;
  bool isLoading = false;
  final validity = TextEditingController();

  @override
  void initState() {
    validity.addListener(() {
      if (CreditCardValidator().validateExpDate(validity.text).isValid) {
        setState(() => isButtonActive = true);
      } else {
        setState(() => isButtonActive = false);
      }
    });
    super.initState();
    context.read<UserService>().readUser();
  }

  _registerCard() async {
    setState(() => isLoading = true);
    if (context.read<UserService>().user?['cards'] < 6) {
      try {
        await context.read<CardService>().registerCard(validity.text);
      } catch (_) {
        setState(() => isLoading = false);
      } finally {
        Navigator.of(context).pushReplacementNamed(Routes.HOME_USER);
      }
    } else {
      _showModal();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'data de validade',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: validity,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    ValidadeCartaoInputFormatter()
                  ],
                  autofocus: true,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                  ),
                  decoration: const InputDecoration(
                    hintText: '00/00',
                    border: InputBorder.none,
                  ),
                  cursorColor: Colors.black,
                ),
              ),
            ),
            BottomButtom(
                loading: isLoading,
                enabled: isButtonActive,
                onPress: () => isButtonActive == true ? _registerCard() : null,
                title: "cadastrar cart??o"),
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
                    'Voc?? j?? possui 6 cart??es',
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
