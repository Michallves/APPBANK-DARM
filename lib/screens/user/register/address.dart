import 'package:appbankdarm/services/auth_service.dart';
import 'package:appbankdarm/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class RegisterAddressUser extends StatefulWidget {
  const RegisterAddressUser({super.key});

  @override
  State<RegisterAddressUser> createState() => _RegisterAddressUserState();
}

class _RegisterAddressUserState extends State<RegisterAddressUser> {
  bool isButtonActive = false;
  final state = TextEditingController();
  final city = TextEditingController();
  final neighborhood = TextEditingController();
  final street = TextEditingController();
  final number = TextEditingController();

  @override
  void initState() {
    super.initState();
    state.addListener(() {
      if (state.text.length > 1) {
        setState(() => isButtonActive = true);
        city.addListener(() {
          if (city.text.length > 1) {
            setState(() => isButtonActive = true);
          } else {
            setState(() => isButtonActive = false);
          }
        });
      } else {
        setState(() => isButtonActive = false);
      }
    });
  }

  void pressButton() {
    context.read<AuthService>().address = [
      {
        "state": state.text,
        "city": city.text,
        "neighborhood": neighborhood.text,
        "street": street.text,
        "number": number.text,
      }
    ];
    Navigator.of(context).pushNamed(AppRoutes.REGISTER_ACCOUNT_TYPE_USER);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Endereço',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: state,
                      autofocus: true,
                      style: const TextStyle(fontSize: 26),
                      decoration: const InputDecoration(
                        labelText: 'Estado',
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        border: InputBorder.none,
                      ),
                      cursorColor: Colors.black,
                      textInputAction: TextInputAction.next,
                    ),
                    TextFormField(
                      controller: city,
                      style: const TextStyle(fontSize: 26),
                      decoration: const InputDecoration(
                        labelText: 'Cidade',
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        border: InputBorder.none,
                      ),
                      cursorColor: Colors.black,
                      textInputAction: TextInputAction.next,
                    ),
                    TextFormField(
                      controller: neighborhood,
                      style: const TextStyle(fontSize: 26),
                      decoration: const InputDecoration(
                        labelText: 'Bairro',
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        border: InputBorder.none,
                      ),
                      cursorColor: Colors.black,
                      textInputAction: TextInputAction.next,
                    ),
                    TextFormField(
                      controller: street,
                      style: const TextStyle(fontSize: 26),
                      decoration: const InputDecoration(
                        labelText: 'Rua',
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        border: InputBorder.none,
                      ),
                      cursorColor: Colors.black,
                      textInputAction: TextInputAction.next,
                    ),
                    TextFormField(
                      controller: number,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      style: const TextStyle(fontSize: 26),
                      decoration: const InputDecoration(
                        labelText: 'Número',
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        border: InputBorder.none,
                      ),
                      cursorColor: Colors.black,
                      textInputAction: TextInputAction.done,
                    ),
                  ],
                ),
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
