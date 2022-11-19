import 'package:appbankdarm/controller/card_service.dart';
import 'package:appbankdarm/utils/app_routes.dart';
import 'package:appbankdarm/widgets/bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateCardName extends StatefulWidget {
  const CreateCardName({super.key});

  @override
  State<CreateCardName> createState() => _CreateCardNameState();
}

class _CreateCardNameState extends State<CreateCardName> {
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

  _pressButton() {
    context.read<CardService>().name = name.text;
    Navigator.of(context).pushNamed(AppRoutes.CREATE_CARD_FLAG);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'solicitar cartão',
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
                onPress: () => _pressButton(),
                title: 'continuar'),
          ],
        ),
      ),
    );
  }
}
