import 'package:appbankdarm/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_routes.dart';

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
    try {
      await context.read<AuthService>().register();
      return Navigator.of(context).pushNamed(AppRoutes.HOMEUSER);
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.message)));
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
          Container(
            width: double.infinity,
            height: 50,
            margin: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: isButtonActive == true
                  ? () {
                      register();
                    }
                  : null,
              child: isLoading == false
                  ? const Text("entrar")
                  : CircularProgressIndicator(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
