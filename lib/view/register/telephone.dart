import 'package:appbankdarm/services/auth_service.dart';
import 'package:appbankdarm/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../widgets/bottom_button.dart';

class RegisterTelephoneUser extends StatefulWidget {
  const RegisterTelephoneUser({super.key});

  @override
  State<RegisterTelephoneUser> createState() => _RegisterTelephoneUserState();
}

class _RegisterTelephoneUserState extends State<RegisterTelephoneUser> {
  bool isButtonActive = false;
  final telephone = TextEditingController();

  @override
  void initState() {
    super.initState();
    telephone.addListener(() {
      if (telephone.text.length >= 14) {
        setState(() => isButtonActive = true);
      } else {
        setState(() => isButtonActive = false);
      }
    });
  }

  _pressButton() {
    context.read<AuthService>().telephone = telephone.text;
    Navigator.of(context).pushNamed(AppRoutes.REGISTER_ADDRESS);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Telefone',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: telephone,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter()
                  ],
                  style: const TextStyle(fontSize: 26),
                  decoration: const InputDecoration(
                    hintText: '(00) 00000-0000',
                    labelText: 'Telefone',
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
            BottomButtom(
              onPress: () => _pressButton(),
              title: 'continuar',
              enabled: isButtonActive,
            )
          ],
        ),
      ),
    );
  }
}
