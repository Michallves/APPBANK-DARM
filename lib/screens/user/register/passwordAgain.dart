import 'package:appbankdarm/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../utils/app_routes.dart';
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

  @override
  void initState() {
    super.initState();
    passwordConfirm.addListener(() {
      if (passwordConfirm.text.length == 6 &&
          context.read<AuthService>().password == passwordConfirm.text) {
        setState(() => isButtonActive = true);
      } else {
        setState(() => isButtonActive = false);
      }
    });
  }

  register() async {
    setState(() {
      isLoading = true;
    });
    late FirebaseFirestore db;
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: context.read<AuthService>().email!,
            password: context.read<AuthService>().password!,
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
                }).then((_) => {
                          Navigator.of(context)
                              .pushReplacementNamed(AppRoutes.HOMEUSER),
                          context.read<AuthService>().getUser()
                        })
              });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('A senha é muito fraca!')));
        setState(() {
          isLoading = false;
        });
      }
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
                autofocus: true,
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
            onPress: () => register(),
            title: 'criar conta',
            isButtonActive: isButtonActive,
            isLoading: isLoading,
          )
        ],
      ),
    );
  }
}
