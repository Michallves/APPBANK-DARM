import 'package:appbankdarm/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/card_service.dart';
import '../../widgets/bottom_button.dart';

class RegisterCardName extends StatefulWidget {
  const RegisterCardName({super.key});

  @override
  State<RegisterCardName> createState() => _RegisterCardNameState();
}

class _RegisterCardNameState extends State<RegisterCardName> {
  bool isButtonActive = false;
  final name = TextEditingController();

  @override
  void initState() {
    name.addListener(() {
      if (name.text.length > 10) {
        setState(() => isButtonActive = true);
      } else {
        setState(() => isButtonActive = false);
      }
    });
    super.initState();
  }

  _pressButton() {
    context.read<CardService>().name = name.text;
    Navigator.of(context).pushNamed(Routes.REGISTER_CARD_NUMBER);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'cadastrar cartão',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: name,
                  autofocus: true,
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
            BottomButtom(
                enabled: isButtonActive,
                onPress: () => isButtonActive == true ? _pressButton() : null,
                title: "continuar")
          ],
        ),
      ),
    );
  }
}
