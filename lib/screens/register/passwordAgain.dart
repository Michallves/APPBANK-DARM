import 'package:appbankdarm/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';
import '../../utils/app_routes.dart';
import '../../widgets/bottom_button.dart';

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
    setState(() => isLoading = true);
    AuthService auth = context.read<AuthService>();
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: auth.email!,
          password: passwordConfirm.text,
        )
        .then((UserCredential userCredential) async => {
              auth.rool == 'user'
                  ? await FirebaseFirestore.instance
                      .collection("users")
                      .doc(userCredential.user?.uid)
                      .set({
                      "cpf": auth.cpf,
                      'name': auth.name,
                      "email": auth.email,
                      "telephone": auth.telephone,
                      "accountType": auth.accountType,
                      "rool": 'user',
                      "address": {
                        'state': auth.address![0],
                        "city": auth.address![1],
                        "neighborhood": auth.address![2],
                        "street": auth.address![3],
                        "number": auth.address![4],
                      },
                    })
                  : await FirebaseFirestore.instance
                      .collection("users")
                      .doc(userCredential.user?.uid)
                      .set({
                      "cpf": auth.cpf,
                      'name': auth.name,
                      "email": auth.email,
                      "rool": 'admin',
                      "address": {
                        'state': auth.address![0],
                        "city": auth.address![1],
                        "neighborhood": auth.address![2],
                        "street": auth.address![3],
                        "number": auth.address![4],
                      },
                    })
            })
        .then((_) {
      auth.getUser();
      if (auth.rool == 'user') {
        Navigator.of(context).pushReplacementNamed(AppRoutes.HOME_USER);
      } else {
        Navigator.of(context).pushReplacementNamed(AppRoutes.HOME_ADMIN);
      }
    }).catchError((_) {
      showModal();
      setState(() => isLoading = false);
    });
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
                      Navigator.of(context).pop(),
                      myFocusNode.requestFocus(),
                    },
                    title: 'tentar novamente',
                    color: Colors.redAccent,
                  )
                ]),
          ));
}
