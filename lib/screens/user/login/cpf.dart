import 'package:appbankdarm/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';

class LoginCpfUser extends StatefulWidget {
  const LoginCpfUser({super.key});

  @override
  State<LoginCpfUser> createState() => _LoginCpfUserState();
}

class _LoginCpfUserState extends State<LoginCpfUser> {
  bool isButtonActive = false;
  bool labelErr = false;
  final cpf = TextEditingController();
  final formFieldKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();
    cpf.addListener(() {
      if (cpf.text.length == 14) {
        setState(() => isButtonActive = true);
      } else {
        setState(() => isButtonActive = false);
        formFieldKey.currentState?.validate();
      }
    });
  }

  pressButton() {
    UtilBrasilFields.isCPFValido(cpf.text) == true
        ? Navigator.of(context).pushNamed(AppRoutes.LOGIN_PASSWORD_USER)
        : formFieldKey.currentState?.validate();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'entrar',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: TextFormField(
                key: formFieldKey,
                controller: cpf,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.none,
                keyboardAppearance: Brightness.dark,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter()
                ],
                autofocus: true,
                style: const TextStyle(fontSize: 26),
                validator: (String? value) {
                  if (UtilBrasilFields.isCPFValido(cpf.text) == false &&
                      cpf.text.length == 14) {
                    setState(() {
                      labelErr = true;
                    });
                    return 'CPF inválido. confira e tente novamente';
                  } else {
                    labelErr = false;
                  }
                },
                decoration: InputDecoration(
                  hintText: '000.000.000-00',
                  labelText: 'digite seu CPF',
                  labelStyle: TextStyle(
                    color: labelErr == true ? Colors.red : Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  errorStyle: const TextStyle(
                    color: Colors.red,
                  ),
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
              onPressed: isButtonActive == true ? () => pressButton() : null,
              child: const Text("continuar"),
            ),
          ),
        ],
      ),
    );
  }
}
