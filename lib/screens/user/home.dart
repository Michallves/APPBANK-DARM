import 'package:firebase_auth/firebase_auth.dart';
import 'package:appbankdarm/widgets/cartao.dart';
import 'package:appbankdarm/utils/app_routes.dart';
import 'package:provider/provider.dart';
import '../../services/user_service.dart';
import '../../repositories/cartao_repository.dart';
import 'package:flutter/material.dart';

class HomeUser extends StatefulWidget {
  const HomeUser({super.key});

  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  final tabela = CartaoRepository.tabela;

  logout() async {
    await FirebaseAuth.instance.signOut().then(
        (_) => Navigator.of(context).pushReplacementNamed(AppRoutes.PRELOAD));
  }

  @override
  Widget build(BuildContext context) {
    print(context.read<UserService>().cards);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cartões',
        ),
      ),
      drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            children: [
              DrawerHeader(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: Text(
                      context.read<UserService>().name,
                      style: const TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                  Text(context.read<UserService>().name,
                      style: const TextStyle(fontSize: 18))
                ],
              )),
              ListTile(
                title: const Text('Conta'),
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRoutes.ACCOUNT_USER),
                leading: const Icon(Icons.account_circle_outlined, size: 30),
                iconColor: Colors.black,
              ),
              ListTile(
                title: const Text('Criar cartão'),
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRoutes.CREATE_CARD_NAME),
                leading: const Icon(Icons.add_card, size: 30),
                iconColor: Colors.black,
              ),
              ListTile(
                title: const Text('Cadastrar cartão'),
                onTap: () => Navigator.of(context)
                    .pushNamed(AppRoutes.REGISTER_CARD_NAME),
                leading: const Icon(Icons.credit_card, size: 30),
                iconColor: Colors.black,
              ),
              ListTile(
                title: const Text('Sair', style: TextStyle(color: Colors.red)),
                onTap: () => logout(),
                leading: const Icon(Icons.logout, size: 30),
                iconColor: Colors.red,
              )
            ],
          )),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int cartao) => Cartao(
                id: tabela[cartao].id,
                number: tabela[cartao].number,
                flag: tabela[cartao].flag,
                name: tabela[cartao].name,
                validity: tabela[cartao].validity,
                cvc: tabela[cartao].cvc,
                type: tabela[cartao].type,
              ),
          padding: const EdgeInsets.all(20),
          separatorBuilder: (_, ____) =>
              const Padding(padding: EdgeInsets.all(10)),
          itemCount: tabela.length),
    );
  }
}
