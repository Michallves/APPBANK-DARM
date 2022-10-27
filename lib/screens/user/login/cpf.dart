import 'package:appbankdarm/utils/app_routes.dart';
import 'package:appbankdarm/widgets/bottom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:appbankdarm/services/auth_service.dart';
import 'package:provider/provider.dart';

class LoginCpfUser extends StatefulWidget {
  const LoginCpfUser({super.key});

  @override
  State<LoginCpfUser> createState() => _LoginCpfUserState();
}

class _LoginCpfUserState extends State<LoginCpfUser> {
  bool isButtonActive = false;
  bool isLoading = false;
  bool labelErr = false;

  final formFieldKey = GlobalKey<FormFieldState>();
  final cpf = TextEditingController();
  String? email;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = false;
    });
    cpf.addListener(() {
      if (cpf.text.length == 14) {
        setState(() => isButtonActive = true);
      } else {
        setState(() => isButtonActive = false);
        formFieldKey.currentState?.validate();
      }
    });
  }

  _validate() {
    formFieldKey.currentState?.validate();
    setState(() => isLoading = false);
  }

  _pushEmail() async {
    await FirebaseFirestore.instance
        .collection("users")
        .where("cpf", isEqualTo: cpf.text)
        .get()
        .then((snapshot) => {
              if (snapshot.docs.isNotEmpty)
                {
                  snapshot.docs.forEach((doc) => {
                        context.read<AuthService>().email = doc.data()["email"],
                        Navigator.of(context)
                            .pushNamed(AppRoutes.LOGIN_PASSWORD_USER)
                      })
                }
              else
                {showModal()}
            });
    setState(() => isLoading = false);
  }

  _pressButton() async {
    setState(() {
      isLoading = true;
    });
    UtilBrasilFields.isCPFValido(cpf.text) == true
        ? {_pushEmail()}
        : {_validate()};
  }

  _notFindCpf() {
    context.read<AuthService>().cpf = cpf.text;
    Navigator.of(context).pushNamed(AppRoutes.REGISTER_NAME_USER);
  }

  void showModal() => showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      context: context,
      builder: (context) => SizedBox(
            height: 300,
            child: Column(children: [
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text(
                    'CPF não encontrado',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'crie um cadastro para você agora mesmo',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              )),
              Column(
                children: [
                  BottomButtom(
                      onPress: () => _notFindCpf(), title: 'criar cadastro'),
                ],
              )
            ]),
          ));

  @override
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
          BottomButtom(
              isLoading: isLoading,
              isButtonActive: isButtonActive,
              onPress: () => _pressButton(),
              title: 'continuar')
        ],
      ),
    );
  }
}
