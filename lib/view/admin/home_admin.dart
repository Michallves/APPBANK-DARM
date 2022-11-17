import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../controller/admin_service.dart';
import '../../controller/auth_service.dart';
import '../../utils/app_routes.dart';
import '../../widgets/cartao.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  bool isLoading = true;
  DocumentSnapshot<Object?>? user;

  @override
  void initState() {
    super.initState();
    _readUser();
  }

  _readUser() async {
    try {
      await context.read<AdminService>().readUser();
    } finally {
      user = context.read<AdminService>().user;
      setState(() {
        isLoading = false;
      });
    }
  }

  _logout() async {
    context.read<AuthService>().logout().then(
        (_) => Navigator.of(context).pushReplacementNamed(AppRoutes.PRELOAD));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cartões solicitados',
        ),
      ),
      drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            children: [
              DrawerHeader(
                  child: isLoading == true
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 40,
                              backgroundImage:
                                  NetworkImage((user?['image']).toString()),
                              child: user?['image'] == ''
                                  ? Text(
                                      (user?['name'])
                                          .toString()
                                          .substring(0, 2)
                                          .toUpperCase(),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 30))
                                  : null,
                            ),
                            Text((user?['name']).toString(),
                                style: const TextStyle(fontSize: 18))
                          ],
                        )),
              ListTile(
                title: const Text('Usuários'),
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRoutes.LIST_USERS),
                leading:
                    const Icon(Icons.supervisor_account_outlined, size: 30),
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
          stream: context.read<AdminService>().readCards(),
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
                        context.read<AdminService>().card = card;
                        Navigator.of(context).pushNamed(AppRoutes.CARD_ADMIN);
                      },
                      child: Cartao(
                        obscure: false,
                        number: card['number'],
                        flag: card['flag'],
                        name: card['name'],
                        validity: card['validity'],
                        cvc: null,
                      ),
                    );
                  }));
            }
          }),
    );
  }
}
