import 'package:appbankdarm/utils/app_routes.dart';
import 'package:flutter/material.dart';

class CreateCardValidity extends StatefulWidget {
  const CreateCardValidity({super.key});

  @override
  State<CreateCardValidity> createState() => _CreateCardValidityState();
}

class _CreateCardValidityState extends State<CreateCardValidity> {
  bool isButtonActive = false;
  String validity = '';

  void pressButton() {
    Navigator.of(context).pushNamed(AppRoutes.HOME);
  }

  @override
  Widget build(BuildContext context) {
    if (validity != '') {
      isButtonActive = true;
    }

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
          Container(
            width: double.infinity,
            height: 50,
            margin: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: isButtonActive == true ? () => pressButton() : null,
              child: const Text("criar cartão"),
            ),
          ),
        ],
      ),
    );
  }
}
