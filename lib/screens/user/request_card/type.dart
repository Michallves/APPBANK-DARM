import 'package:appbankdarm/utils/app_routes.dart';
import 'package:appbankdarm/widgets/bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/card_service.dart';

class CreateCardType extends StatefulWidget {
  const CreateCardType({super.key});

  @override
  State<CreateCardType> createState() => _CreateCardTypeState();
}

class _CreateCardTypeState extends State<CreateCardType> {
  String type = '';

  _pressButton() {
    context.read<CardService>().type = type;
    Navigator.of(context).pushNamed(AppRoutes.CREATE_CARD_VALIDITY);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'tipo de conta',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Crédito'),
                    onTap: () => setState(() {
                      type = 'credit';
                    }),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    leading: Radio(
                      value: 'credit',
                      activeColor: Colors.black,
                      groupValue: type,
                      onChanged: ((String? value) {
                        setState(() {
                          type = value.toString();
                        });
                      }),
                    ),
                  ),
                  ListTile(
                    title: const Text('Débito'),
                    onTap: () => setState(() {
                      type = 'debit';
                    }),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    leading: Radio(
                      value: 'debit',
                      activeColor: Colors.black,
                      groupValue: type,
                      onChanged: ((String? value) {
                        setState(() {
                          type = value.toString();
                        });
                      }),
                    ),
                  ),
                  ListTile(
                    title: const Text('Poupança'),
                    onTap: () => setState(() {
                      type = 'savings';
                    }),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    leading: Radio(
                      value: 'savings',
                      activeColor: Colors.black,
                      groupValue: type,
                      onChanged: ((String? value) {
                        setState(() {
                          type = value.toString();
                        });
                      }),
                    ),
                  ),
                  ListTile(
                    title: const Text('Crédito e Débito'),
                    onTap: () => setState(() {
                      type = 'credit&debit';
                    }),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    leading: Radio(
                      value: 'credit&debit',
                      activeColor: Colors.black,
                      groupValue: type,
                      onChanged: ((String? value) {
                        setState(() {
                          type = value.toString();
                        });
                      }),
                    ),
                  ),
                  ListTile(
                    title: const Text('Poupança e Débito'),
                    onTap: () => setState(() {
                      type = 'savingst&debit';
                    }),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    leading: Radio(
                      value: 'savingst&debit',
                      activeColor: Colors.black,
                      groupValue: type,
                      onChanged: ((String? value) {
                        setState(() {
                          type = value.toString();
                        });
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
          BottomButtom(
              enabled: type != '' ? true : false,
              onPress: () => _pressButton(),
              title: 'continuar')
        ],
      ),
    );
  }
}
