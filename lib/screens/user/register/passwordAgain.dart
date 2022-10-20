import 'package:appbankdarm/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class RegisterPasswordAgainUser extends StatefulWidget {
  const RegisterPasswordAgainUser({super.key});

  @override
  State<RegisterPasswordAgainUser> createState() =>
      _RegisterPasswordAgainUserState();
}

class _RegisterPasswordAgainUserState extends State<RegisterPasswordAgainUser> {
  bool isButtonActive = false;
  final password = TextEditingController();

  @override
  void initState() {
    super.initState();
    password.addListener(() {
      if (password.text.length == 6) {
        setState(() => isButtonActive = true);
      } else {
        setState(() => isButtonActive = false);
      }
      print(password.text);
    });
  }

  void pressButton() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.HOME, (Route<dynamic> route) => false);
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
                controller: password,
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
                      pressButton();
                    }
                  : null,
              child: const Text("entrar"),
            ),
          ),
        ],
      ),
    );
  }
}
