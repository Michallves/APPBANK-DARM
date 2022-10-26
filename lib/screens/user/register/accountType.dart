import 'package:appbankdarm/services/auth_service.dart';
import 'package:appbankdarm/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/bottom_button.dart';

class RegisterAccountTypeUser extends StatefulWidget {
  const RegisterAccountTypeUser({super.key});

  @override
  State<RegisterAccountTypeUser> createState() =>
      _RegisterAccountTypeUserState();
}

class _RegisterAccountTypeUserState extends State<RegisterAccountTypeUser> {
  bool isButtonActive = false;
  String accountType = '';

  _pressButton() {
    context.read<AuthService>().accountType = accountType;
    Navigator.of(context).pushNamed(AppRoutes.REGISTER_PASSWORD_USER);
  }

  @override
  Widget build(BuildContext context) {
    if (accountType != '') {
      isButtonActive = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'tipo de conta',
        ),
      ),
      body: Column(
        children: [
          Expanded(
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
          BottomButtom(
            onPress: () => _pressButton(),
            title: 'continuar',
            isButtonActive: isButtonActive,
          )
        ],
      ),
    );
  }
}
