import 'package:flutter/material.dart';

class InfoUser extends StatelessWidget {
  const InfoUser(
      {super.key,
      required this.name,
      required this.cpf,
      required this.number,
      required this.typeAccount,
      required this.email});

  final String? name;
  final String? cpf;
  final String? number;
  final String? typeAccount;
  final String? email;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Nome',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                Text(
                  name!,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.all(10)),
          SizedBox(
            height: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('CPF',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                Text(
                  cpf!,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.all(10)),
          SizedBox(
            height: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Email',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                Text(
                  email!,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.all(10)),
          Row(
            children: [
              SizedBox(
                height: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Telefone',
                        style:
                            TextStyle(fontSize: 16, color: Colors.grey[700])),
                    Text(
                      number!,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.all(40)),
              SizedBox(
                height: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Tipo de conta',
                        style:
                            TextStyle(fontSize: 16, color: Colors.grey[700])),
                    Text(
                      typeAccount == 'savings'
                          ? 'Poupança'
                          : typeAccount == 'current'
                              ? 'Corrente'
                              : '',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
          const Padding(padding: EdgeInsets.all(40))
        ],
      ),
    );
  }
}
