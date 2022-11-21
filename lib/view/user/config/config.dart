import 'package:appbankdarm/utils/app_routes.dart';
import 'package:appbankdarm/widgets/bottom_button.dart';
import 'package:flutter/material.dart';

class ConfigUser extends StatefulWidget {
  const ConfigUser({super.key});

  @override
  State<ConfigUser> createState() => _ConfigUserState();
}

class _ConfigUserState extends State<ConfigUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'configuração',
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
               
                ListTile(
                  onTap: () => Navigator.of(context)
                      .pushNamed(AppRoutes.CURRENT_PASSWORD),
                  title: const Text('alterar senha'),
                  trailing: const Icon(Icons.arrow_forward),
                ),
                const Divider(),
                ListTile(
                  onTap: () =>
                      Navigator.of(context).pushNamed(AppRoutes.DELETE),
                  title: const Text('excluir conta'),
                  trailing: const Icon(Icons.arrow_forward),
                ),
                const Divider(),
              ],
            ),
          ),
        ));
  }
}
