import 'package:appbankdarm/services/auth_service.dart';
import 'package:appbankdarm/services/card_service.dart';
import 'package:appbankdarm/services/user_service.dart';
import 'package:appbankdarm/widgets/cartao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appbankdarm/utils/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class HomeUser extends StatefulWidget {
  const HomeUser({super.key});

  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  bool isLoading = false;

  @override
  void initState() {
    _readUser();
    super.initState();
  }

  _readUser() async {
    await context.read<UserService>().readUser();
  }

  _logout() async {
    await context.read<AuthService>().logout();
  }

  @override
  Widget build(BuildContext context) {
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
                    backgroundColor: Colors.black,
                    radius: 40,
                    backgroundImage: NetworkImage(
                        context.read<UserService>().image.toString()),
                    child: context.read<UserService>().image == null
                        ? Text(
                            context
                                .read<UserService>()
                                .name
                                .toString()
                                .substring(0, 2)
                                .toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 30))
                        : null,
                  ),
                  Text(
                      context.read<UserService>().name == null
                          ? ''
                          : context.read<UserService>().name.toString(),
                      style: const TextStyle(fontSize: 18))
                ],
              )),
              ListTile(
                title: const Text('Conta'),
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.ACCOUNT),
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
                onTap: () => _logout(),
                leading: const Icon(Icons.logout, size: 30),
                iconColor: Colors.red,
              )
            ],
          )),
      body: StreamBuilder<QuerySnapshot>(
          stream: context.read<CardService>().readCards(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.black),
              );
            } else {
              return ListView.separated(
                  padding: const EdgeInsets.all(20),
                  separatorBuilder: (_, ___) =>
                      const Padding(padding: EdgeInsets.all(10)),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    DocumentSnapshot card = snapshot.data!.docs[index];
                    return GestureDetector(
                      onTap: () {
                        context.read<CardService>().id = card.id;
                        Navigator.of(context).pushNamed(AppRoutes.CARD_USER);
                      },
                      child: Cartao(
                        number: card['number'],
                        flag: card['flag'],
                        name: card['name'],
                        validity: card['validity'],
                      ),
                    );
                  }));
            }
          }),
    );
  }
}
