import 'package:appbankdarm/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../widgets/bottom_button.dart';

class RegisterPasswordAgainUser extends StatefulWidget {
  const RegisterPasswordAgainUser({super.key});

  @override
  State<RegisterPasswordAgainUser> createState() =>
      _RegisterPasswordAgainUserState();
}

class _RegisterPasswordAgainUserState extends State<RegisterPasswordAgainUser> {
  bool isButtonActive = false;
  bool isLoading = false;
  final passwordConfirm = TextEditingController();
  late FocusNode myFocusNode;
  @override
  void initState() {
    myFocusNode = FocusNode();
    myFocusNode.requestFocus();
    passwordConfirm.addListener(() {
      if (passwordConfirm.text.length == 6) {
        setState(() => isButtonActive = true);
      } else {
        setState(() => isButtonActive = false);
      }
    });
    super.initState();
  }

  _register() async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: context.read<AuthService>().email!,
            password: passwordConfirm.text,
          )
          .then((UserCredential userCredential) async => {
                await FirebaseFirestore.instance
                    .collection("users")
                    .doc(userCredential.user?.uid)
                    .set({
                  "cpf": context.read<AuthService>().cpf!,
                  'name': context.read<AuthService>().name!,
                  "email": context.read<AuthService>().email!,
                  "telephone": context.read<AuthService>().telephone!,
                  "accountType": context.read<AuthService>().accountType!,
                  "address": {
                    'state': context.read<AuthService>().address![0],
                    "city": context.read<AuthService>().address![1],
                    "neighborhood": context.read<AuthService>().address![2],
                    "street": context.read<AuthService>().address![3],
                    "number": context.read<AuthService>().address![4],
                  },
                }),
                context.read<AuthService>().user = userCredential.user,
              });
    } on FirebaseAuthException catch (_) {
      showModal();
    }
  }

  _pressButton() {
    if (context.read<AuthService>().password == passwordConfirm.text) {
      _register();
    } else {
      showModal();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'senha novamente',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 40),
              child: PinCodeTextField(
                controller: passwordConfirm,
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
          BottomButtom(
            onPress: () => _pressButton(),
            title: 'criar conta',
            enabled: isButtonActive,
            loading: isLoading,
          )
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
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text(
                        'as senhas são diferentes',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'a senha e a confirmação de senha precisam ser exatamentes iguais',
                         textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  )),
                  BottomButtom(
                    onPress: () => {
                      setState(() => {
                            isLoading = false,
                          }),
                      Navigator.of(context).pop(),
                      myFocusNode.requestFocus(),
                    },
                    title: 'tentar novamente',
                    color: Colors.redAccent,
                  )
                ]),
          ));
}
