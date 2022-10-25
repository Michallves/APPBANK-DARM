import 'package:appbankdarm/databases/db_firestore.dart';
import 'package:appbankdarm/utils/app_routes.dart';
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

  pressButton() async {
    setState(() {
      isLoading = true;
    });
    UtilBrasilFields.isCPFValido(cpf.text) == true
        ? {pushEmail()}
        : {
            formFieldKey.currentState?.validate(),
            setState(() => isLoading = false)
          };
  }

  pushEmail() async {
    db = DBFirestore.get();
    await db
        .collection("users")
        .where("cpf", isEqualTo: cpf.text)
        .get()
        .then((snapshot) => {
              if (snapshot.docs.isNotEmpty)
                {
                  snapshot.docs.forEach((doc) => {
                        context.read<AuthService>().email = doc.data()["email"],
                        setState(() => isLoading = false),
                        Navigator.of(context)
                            .pushNamed(AppRoutes.LOGIN_PASSWORD_USER)
                      })
                }
              else
                {setState(() => isLoading = false), showBottomSheet()}
            });
  }

  void showBottomSheet() => showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
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
                  Container(
                    width: double.infinity,
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                        onPressed: () => Navigator.of(context)
                            .pushNamed(AppRoutes.REGISTER_CPF_USER),
                        child: const Text('criar cadastro')),
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    margin: const EdgeInsets.all(20),
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        side: MaterialStateProperty.all(
                          const BorderSide(
                            width: 3,
                          ),
                        ),
                        elevation: ButtonStyleButton.allOrNull(0.0),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      child: const Text(
                        "agora não",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              )
            ]),
          ));
  late FirebaseFirestore db;

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
              child: isLoading == false
                  ? const Text("entrar")
                  : const SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
