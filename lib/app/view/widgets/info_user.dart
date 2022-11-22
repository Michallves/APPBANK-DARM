import 'package:flutter/material.dart';
import '../../models/user_model.dart';

class InfoUser extends StatelessWidget {
  final UserModel user;

  const InfoUser(this.user, {super.key});

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
          infoUser(title: 'Nome', value: user.name!),
          infoUser(title: 'CPF', value: user.cpf!),
          infoUser(title: 'Email', value: user.email!),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              infoUser(title: 'Telefone', value: user.telephone!),
              infoUser(
                  title: 'Tipo de conta',
                  value: user.accountType == 'savings'
                      ? 'Poupança'
                      : user.accountType == 'current'
                          ? 'Corrente'
                          : ''),
              const Padding(padding: EdgeInsets.all(0)),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              infoUser(title: 'Estado', value: user.state!),
              infoUser(
                title: 'Cidade',
                value: user.address?['city'],
              ),
              const Padding(padding: EdgeInsets.all(0)),
            ],
          ),
          infoUser(title: 'Rua', value: user.address?['street']),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              infoUser(
                  title: 'Bairro', value: user.address?['neighborhood']),
              infoUser(
                title: 'Número',
                value: user.address?['number'],
              ),
              const Padding(padding: EdgeInsets.all(0)),
            ],
          ),
        ],
      ),
    );
  }
}
