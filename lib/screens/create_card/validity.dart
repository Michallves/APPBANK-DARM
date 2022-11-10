import 'package:appbankdarm/utils/app_routes.dart';
import 'package:appbankdarm/widgets/bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/card_service.dart';

class CreateCardValidity extends StatefulWidget {
  const CreateCardValidity({super.key});

  @override
  State<CreateCardValidity> createState() => _CreateCardValidityState();
}

class _CreateCardValidityState extends State<CreateCardValidity> {
  bool isLoading = false;
  String validity = '';

  _createCard() async {
    setState(() => isLoading = true);
    try {
      await context.read<CardService>().createCard(validity);
      return Navigator.of(context).pushNamed(AppRoutes.HOMEUSER);
    } catch (_) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'validade',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    title: const Text('2 anos'),
                    onTap: () => setState(() {
                      validity = '2';
                    }),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    leading: Radio(
                      value: '2',
                      activeColor: Colors.black,
                      groupValue: validity,
                      onChanged: ((String? value) {
                        setState(() {
                          validity = value.toString();
                        });
                      }),
                    ),
                  ),
                  ListTile(
                    title: const Text('4 anos'),
                    onTap: () => setState(() {
                      validity = '4';
                    }),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    leading: Radio(
                      value: '4',
                      activeColor: Colors.black,
                      groupValue: validity,
                      onChanged: ((String? value) {
                        setState(() {
                          validity = value.toString();
                        });
                      }),
                    ),
                  ),
                  ListTile(
                    title: const Text('5 anos'),
                    onTap: () => setState(() {
                      validity = '5';
                    }),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    leading: Radio(
                      value: '5',
                      activeColor: Colors.black,
                      groupValue: validity,
                      onChanged: ((String? value) {
                        setState(() {
                          validity = value.toString();
                        });
                      }),
                    ),
                  ),
                  ListTile(
                    title: const Text('6 anos'),
                    onTap: () => setState(() {
                      validity = '6';
                    }),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    leading: Radio(
                      value: '6',
                      activeColor: Colors.black,
                      groupValue: validity,
                      onChanged: ((String? value) {
                        setState(() {
                          validity = value.toString();
                        });
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
          BottomButtom(
              loading: isLoading,
              enabled: validity != '' ? true : false,
              onPress: () => _createCard(),
              title: 'solicitar cartão')
        ],
      ),
    );
  }
}
