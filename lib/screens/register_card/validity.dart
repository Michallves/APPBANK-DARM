import 'package:appbankdarm/utils/app_routes.dart';

import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../services/card_service.dart';
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
      if (validity.text.length == 5 &&
          int.parse(UtilBrasilFields.removeCaracteres(validity.text)) < 1230) {
        setState(() => isButtonActive = true);
      } else {
        setState(() => isButtonActive = false);
      }
    });
    super.initState();
  }

  _registerCard() async {
    setState(() => isLoading = true);
    try {
      await context.read<CardService>().registerCard(validity.text);
    } catch (_) {
      setState(() => isLoading = false);
    } finally {
      Navigator.of(context).pushNamed(AppRoutes.HOME_USER);
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
      body: Column(
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
                style: const TextStyle(fontSize: 26),
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
              title: "cadastrar cartão"),
        ],
      ),
    );
  }
}
