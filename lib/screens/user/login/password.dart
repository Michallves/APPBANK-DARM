import 'package:appbankdarm/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_routes.dart';
import '../../../widgets/bottom_button.dart';

class LoginPasswordUser extends StatefulWidget {
  const LoginPasswordUser({super.key});

  @override
  State<LoginPasswordUser> createState() => _LoginPasswordUserState();
}

class _LoginPasswordUserState extends State<LoginPasswordUser> {
  bool isButtonActive = false;
  bool isLoading = false;
  final password = TextEditingController();
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    password.addListener(() {
      if (password.text.length == 6) {
        setState(() => isButtonActive = true);
      } else {
        setState(() => isButtonActive = false);
      }
    });
  }

  _login() async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: context.read<AuthService>().email!,
              password: password.text)
          .then((_) => {
                Navigator.of(context).pushNamed(AppRoutes.HOMEUSER),
                context.read<AuthService>().getUser()
              });
    } on FirebaseAuthException catch (_) {
      _showModal();
    }
  }

  _showModal() => showModalBottomSheet(
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      context: context,
      builder: (context) => SizedBox(
            height: 250,
            child: Column(children: [
              Expanded(
                  child: Column(
                children: const [
                  Text(
                    'Senha incorreta!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'a senha que você inseriu está incorreta. Tente novamente.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              )),
              Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.all(20),
                child: ElevatedButton(
                    onPressed: () => {
                          setState(() => {
                                password.clear(),
                                password.clearComposing(),
                                isLoading = false,
                              }),
                          Navigator.of(context).pop(),
                          myFocusNode.requestFocus(),
                        },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[600],
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Tentar novamente')),
              )
            ]),
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'senha',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 40),
              child: PinCodeTextField(
                autofocus: true,
                controller: password,
                focusNode: myFocusNode,
                keyboardType: TextInputType.number,
                errorBorderColor: Colors.red,
                pinBoxWidth: 35,
                pinBoxHeight: 50,
                pinBoxRadius: 10,
                pinBoxOuterPadding: const EdgeInsets.symmetric(horizontal: 10),
                wrapAlignment: WrapAlignment.spaceAround,
                maxLength: 6,
                hideCharacter: true,
                maskCharacter: '•',
                pinTextStyle: const TextStyle(fontSize: 20),
                highlight: true,
                defaultBorderColor: Colors.black38,
                hasTextBorderColor: Colors.black38,
              ),
            ),
          ),
          Column(
            children: [
              const TextButton(
                onPressed: null,
                child: Text('recuperar senha',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
              BottomButtom(
                onPress: () => _login(),
                title: 'entrar',
                isButtonActive: isButtonActive,
                isLoading: isLoading,
              )
            ],
          ),
        ],
      ),
    );
  }
}
