import 'package:appbankdarm/services/auth_service.dart';
import 'package:appbankdarm/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';

class LoginPasswordUser extends StatefulWidget {
  const LoginPasswordUser({super.key});

  @override
  State<LoginPasswordUser> createState() => _LoginPasswordUserState();
}

class _LoginPasswordUserState extends State<LoginPasswordUser> {
  bool isButtonActive = false;
  final email = TextEditingController(text: 'maicon@gmail.com');
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
      print(password.text.length);
    });
  }

  login() async {
    try {
      await context.read<AuthService>().login(email.text, password.text);
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

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
                child: ElevatedButton(
                  onPressed: isButtonActive == true
                      ? () {
                          login();
                        }
                      : null,
                  child: const Text("entrar"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
