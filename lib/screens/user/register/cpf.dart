import 'package:appbankdarm/services/auth_service.dart';
import 'package:appbankdarm/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../databases/db_firestore.dart';

class RegisterCpfUser extends StatefulWidget {
  const RegisterCpfUser({super.key});

  @override
  State<RegisterCpfUser> createState() => _RegisterCpfUserState();
}

class _RegisterCpfUserState extends State<RegisterCpfUser> {
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
      }
    });
  }

  void pressButton() async {
    UtilBrasilFields.isCPFValido(cpf.text) == true
        ? {
            await DBFirestore.get()
                .collection("users")
                .where("cpf", isEqualTo: cpf.text)
                .get()
                .then(
                  (res) => {
                    if (res.docs.isNotEmpty)
                      {showBottomSheet()}
                    else
                      {
                        context.read<AuthService>().cpf = cpf.text,
                        Navigator.of(context)
                            .pushNamed(AppRoutes.REGISTER_NAME_USER)
                      }
                  },
                )
          }
        : formFieldKey.currentState?.validate();
  }

  void showBottomSheet() => showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (context) => SizedBox(
            height: 220,
            child: Column(children: [
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text(
                    'CPF já cadastrado',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'toque em ${'entrar'} para acessar sua conta.',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              )),
              Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.all(20),
                child: ElevatedButton(
                    onPressed: () => Navigator.of(context)
                        .pushNamed(AppRoutes.LOGIN_CPF_USER),
                    child: const Text('entrar')),
              )
            ]),
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'seus dados',
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
                  labelText: 'qual seu CPF?',
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
