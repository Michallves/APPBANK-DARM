import 'package:appbankdarm/utils/app_routes.dart';
import 'package:flutter/material.dart';

class RegisterAccountTypeUser extends StatefulWidget {
  const RegisterAccountTypeUser({super.key});

  @override
  State<RegisterAccountTypeUser> createState() =>
      _RegisterAccountTypeUserState();
}

class _RegisterAccountTypeUserState extends State<RegisterAccountTypeUser> {
  bool isButtonActive = false;
  String accountType = '';

  void pressButton() {
    Navigator.of(context).pushNamed(AppRoutes.REGISTER_PASSWORD_USER);
  }

  @override
  Widget build(BuildContext context) {
    if (accountType != '') {
      isButtonActive = true;
    }
    print(accountType);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'tipo de conta',
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(children: [
              ListTile(
                title: const Text('Poupança'),
                onTap: () => setState(() {
                  accountType = 'savings';
                }),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                leading: Radio(
                  value: 'savings',
                  activeColor: Colors.black,
                  groupValue: accountType,
                  onChanged: ((String? value) {
                    setState(() {
                      accountType = value.toString();
                    });
                  }),
                ),
              ),
              ListTile(
                title: const Text('Corrente'),
                onTap: () => setState(() {
                  accountType = 'current';
                }),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                leading: Radio(
                  value: 'current',
                  activeColor: Colors.black,
                  groupValue: accountType,
                  onChanged: ((String? value) {
                    setState(() {
                      accountType = value.toString();
                    });
                  }),
                ),
              ),
            ]),
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
