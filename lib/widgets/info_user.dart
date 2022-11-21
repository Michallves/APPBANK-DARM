import 'package:appbankdarm/models/usuario.dart';
import 'package:flutter/material.dart';

class InfoUser extends StatelessWidget {
  final Usuario usuario;

  const InfoUser(this.usuario, {super.key});

  infoUser({required String title, required String value}) {
    return SizedBox(
      height: 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(title, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Padding(padding: EdgeInsets.all(10)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          infoUser(title: 'Nome', value: usuario.name!),
          infoUser(title: 'CPF', value: usuario.cpf!),
          infoUser(title: 'Email', value: usuario.email!),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              infoUser(title: 'Telefone', value: usuario.telephone!),
              infoUser(
                  title: 'Tipo de conta',
                  value: usuario.accountType == 'savings'
                      ? 'Poupança'
                      : usuario.accountType == 'current'
                          ? 'Corrente'
                          : ''),
              const Padding(padding: EdgeInsets.all(0)),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              infoUser(title: 'Estado', value: usuario.state!),
              infoUser(
                title: 'Cidade',
                value: usuario.address?['city'],
              ),
              const Padding(padding: EdgeInsets.all(0)),
            ],
          ),
          infoUser(title: 'Rua', value: usuario.address?['street']),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              infoUser(
                  title: 'Bairro', value: usuario.address?['neighborhood']),
              infoUser(
                title: 'Número',
                value: usuario.address?['number'],
              ),
              const Padding(padding: EdgeInsets.all(0)),
            ],
          ),
        ],
      ),
    );
  }
}
