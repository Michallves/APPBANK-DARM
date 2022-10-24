import 'package:appbankdarm/services/auth_service.dart';
import 'package:appbankdarm/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterNameUser extends StatefulWidget {
  const RegisterNameUser({super.key});

  @override
  State<RegisterNameUser> createState() => _RegisterNameUserState();
}

class _RegisterNameUserState extends State<RegisterNameUser> {
  bool isButtonActive = false;
  final name = TextEditingController();

  @override
  void initState() {
    super.initState();
    name.addListener(() {
      if (name.text.length > 10) {
        setState(() => isButtonActive = true);
      } else {
        setState(() => isButtonActive = false);
      }
    });
  }

  void pressButton() {
    context.read<AuthService>().name = name.text;
    Navigator.of(context).pushNamed(AppRoutes.REGISTER_EMAIL_USER);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'nome',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: TextField(
                controller: name,
                autofocus: true,
                keyboardType: TextInputType.name,
                style: const TextStyle(fontSize: 26),
                decoration: const InputDecoration(
                  labelText: 'nome completo',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
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
              child: const Text("continuar"),
            ),
          ),
        ],
      ),
    );
  }
}
