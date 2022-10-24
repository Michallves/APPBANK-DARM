import 'package:appbankdarm/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_routes.dart';

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
    myFocusNode = FocusNode();
    super.initState();
    password.addListener(() {
      if (password.text.length == 6) {
        setState(() => isButtonActive = true);
      } else {
        setState(() => isButtonActive = false);
      }
    });
  }

  login() async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: context.read<AuthService>().email!,
              password: password.text)
          .then((_) => Navigator.of(context).pushNamed(AppRoutes.HOMEUSER));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Senha incorreta. Tente novamente')));
      }
      showBottomSheet();
    }
  }

  void showBottomSheet() => showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (context) => SizedBox(
            height: 220,
            child: Column(children: [
              const Expanded(
                  child: Center(
                      child: Text(
                'Senha incorreta!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ))),
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
              Container(
                  width: double.infinity,
                  height: 50,
                  margin: const EdgeInsets.all(20),
                  child: isLoading == false
                      ? ElevatedButton(
                          onPressed: isButtonActive == true
                              ? () {
                                  login();
                                }
                              : null,
                          child: const Text("entrar"))
                      : ElevatedButton(
                          onPressed: null,
                          style: ElevatedButton.styleFrom(
                            disabledBackgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: SizedBox(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        )),
            ],
          ),
        ],
      ),
    );
  }
}
