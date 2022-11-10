import 'package:appbankdarm/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../services/admin_service.dart';
import '../utils/app_routes.dart';
import '../widgets/cartao.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  void initState() {
    context.read<AdminService>().readCards();
    super.initState();
  }

  _logout() async {
    await context.read<AuthService>().logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin',
        ),
      ),
      drawer: Drawer(
          backgroundColor: Colors.white,
          child: DrawerHeader(
              child: ListTile(
            title: const Text('Sair', style: TextStyle(color: Colors.red)),
            onTap: () => _logout(),
            leading: const Icon(Icons.logout, size: 30),
            iconColor: Colors.red,
          ))),
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
                        context.read<AdminService>().readCard(card.id);
                        Navigator.of(context).pushNamed(AppRoutes.CARD_ADMIN);
                      },
                      child: Cartao(
                        number: '0000000000000000',
                        flag: card['flag'],
                        name: card['name'],
                        validity:
                            DateTime.utc(2).year.toString() + card['validity'],
                      ),
                    );
                  }));
            }
          }),
    );
  }
}
