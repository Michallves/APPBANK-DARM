import 'package:appbankdarm/services/auth_service.dart';
import 'package:appbankdarm/services/card_service.dart';
import 'package:appbankdarm/services/user_service.dart';
import 'package:appbankdarm/utils/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
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
        body: SafeArea(child: Container()));
  }
}
