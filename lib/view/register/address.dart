import 'package:appbankdarm/controller/auth_service.dart';
import 'package:appbankdarm/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../widgets/bottom_button.dart';

class RegisterAddressUser extends StatefulWidget {
  const RegisterAddressUser({super.key});

  @override
  State<RegisterAddressUser> createState() => _RegisterAddressUserState();
}

class _RegisterAddressUserState extends State<RegisterAddressUser> {
  bool isButtonActive = false;
  String? state;
  final city = TextEditingController();
  final neighborhood = TextEditingController();
  final street = TextEditingController();
  final number = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  _pressButton() {
    context.read<AuthService>().address = [
      state!,
      city.text,
      neighborhood.text,
      street.text,
      number.text,
    ];
    context.read<AuthService>().role == 'user'
        ? Navigator.of(context).pushNamed(AppRoutes.REGISTER_ACCOUNT_TYPE)
        : Navigator.of(context).pushNamed(AppRoutes.REGISTER_PASSWORD);
  }

  List<String> states = [
    "Acre",
    "Alagoas",
    "Amapá",
    "Amazonas",
    "Bahia",
    "Ceará",
    "Distrito Federal",
    "Espírito Santo",
    "Goiás",
    "Maranhão",
    "Mato Grosso",
    "Mato Grosso do Sul",
    "Minas Gerais",
    "Pará",
    "Paraíba",
    "Paraná",
    "Pernambuco",
    "Piauí",
    "Rio de Janeiro",
    "Rio Grande do Norte",
    "Rio Grande do Sul",
    "Rondônia",
    "Roraima",
    "Santa Catarina",
    "São Paulo",
    "Sergipe",
    "Tocantins",
  ];

  @override
  Widget build(BuildContext context) {
    if (state != null) {
      setState(() => isButtonActive = true);
    } else {
      setState(() => isButtonActive = false);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Endereço',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      DropdownButton(
                          dropdownColor: Colors.white,
                          focusColor: Colors.transparent,
                          hint: const Text(
                            'Estado',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          itemHeight: 70,
                          isExpanded: true,
                          value: state,
                          items: states.map((state) {
                            return DropdownMenuItem(
                              value: state,
                              child: Text(state),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              state = newValue;
                            });
                          }),
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
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            border: UnderlineInputBorder()),
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
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          border: UnderlineInputBorder(),
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
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          border: UnderlineInputBorder(),
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
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          border: UnderlineInputBorder(),
                        ),
                        cursorColor: Colors.black,
                        textInputAction: TextInputAction.done,
                      ),
                    ],
                  ),
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
