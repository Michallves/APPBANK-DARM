import 'package:flutter/material.dart';

class CreateCardFlag extends StatefulWidget {
  const CreateCardFlag({super.key});

  @override
  State<CreateCardFlag> createState() => _CreateCardFlagState();
}

class _CreateCardFlagState extends State<CreateCardFlag> {
  bool isButtonActive = false;
  String flag = '';

  pressButton() {
    Navigator.of(context).pushNamed('/createCardValidity');
  }

  @override
  Widget build(BuildContext context) {
    if (flag != '') {
      isButtonActive = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'bandeira',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(children: [
              ListTile(
                title: const Text('Visa'),
                onTap: () => setState(() {
                  flag = 'visa';
                }),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                leading: Radio(
                  value: 'visa',
                  activeColor: Colors.black,
                  groupValue: flag,
                  onChanged: ((String? value) {
                    setState(() {
                      flag = value.toString();
                    });
                  }),
                ),
              ),
              ListTile(
                title: const Text('Mastercard'),
                onTap: () => setState(() {
                  flag = 'mastercard';
                }),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                leading: Radio(
                  value: 'mastercard',
                  activeColor: Colors.black,
                  groupValue: flag,
                  onChanged: ((String? value) {
                    setState(() {
                      flag = value.toString();
                    });
                  }),
                ),
              ),
              ListTile(
                title: const Text('Elo'),
                onTap: () => setState(() {
                  flag = 'elo';
                }),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                leading: Radio(
                  value: 'elo',
                  activeColor: Colors.black,
                  groupValue: flag,
                  onChanged: ((String? value) {
                    setState(() {
                      flag = value.toString();
                    });
                  }),
                ),
              ),
              ListTile(
                title: const Text('Hipercard'),
                onTap: () => setState(() {
                  flag = 'hipercard';
                }),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                leading: Radio(
                  value: 'hipercard',
                  activeColor: Colors.black,
                  groupValue: flag,
                  onChanged: ((String? value) {
                    setState(() {
                      flag = value.toString();
                    });
                  }),
                ),
              ),
              ListTile(
                title: const Text('American Express'),
                onTap: () => setState(() {
                  flag = 'americanexpress';
                }),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                leading: Radio(
                  value: 'americanexpress',
                  activeColor: Colors.black,
                  groupValue: flag,
                  onChanged: ((String? value) {
                    setState(() {
                      flag = value.toString();
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
