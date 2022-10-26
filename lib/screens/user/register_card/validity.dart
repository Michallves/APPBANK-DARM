import 'package:appbankdarm/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';

class RegisterCardValidity extends StatefulWidget {
  const RegisterCardValidity({super.key});

  @override
  State<RegisterCardValidity> createState() => _RegisterCardValidityState();
}

class _RegisterCardValidityState extends State<RegisterCardValidity> {
  bool isButtonActive = false;
  final validity = TextEditingController();

  @override
  void initState() {
    super.initState();
    validity.addListener(() {
      if (validity.text.length == 5 &&
          int.parse(UtilBrasilFields.removeCaracteres(validity.text)) < 1230) {
        setState(() => isButtonActive = true);
      } else {
        setState(() => isButtonActive = false);
      }
    });
  }

  _pressButton() {
    Navigator.of(context).pushNamed(AppRoutes.HOMEUSER);
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
          Container(
            width: double.infinity,
            height: 50,
            margin: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: isButtonActive == true ? () => _pressButton() : null,
              child: const Text("cadastrar cartão"),
            ),
          ),
        ],
      ),
    );
  }
}
