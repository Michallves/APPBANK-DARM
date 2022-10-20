import 'package:appbankdarm/utils/app_routes.dart';
import 'package:flutter/material.dart';

class RegisterEmailUser extends StatefulWidget {
  const RegisterEmailUser({super.key});

  @override
  State<RegisterEmailUser> createState() => _RegisterEmailUserState();
}

class _RegisterEmailUserState extends State<RegisterEmailUser> {
  bool isButtonActive = false;
  final email = TextEditingController();

  @override
  void initState() {
    super.initState();
    email.addListener(() {
      if (email.text.length > 10) {
        setState(() => isButtonActive = true);
      } else {
        setState(() => isButtonActive = false);
      }
    });
  }

  void pressButton() {
    Navigator.of(context).pushNamed(AppRoutes.REGISTER_TELEPHONE_USER);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'E-mail',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: TextFormField(
                controller: email,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(fontSize: 26),
                decoration: const InputDecoration(
                  labelText: 'E-mail',
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
