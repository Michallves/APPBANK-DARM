import 'package:appbankdarm/widgets/my_cards.dart';
import 'package:appbankdarm/services/user_service.dart';
import 'package:appbankdarm/widgets/requested_cards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appbankdarm/utils/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../services/auth_service.dart';

class HomeUser extends StatefulWidget {
  const HomeUser({super.key});

  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  bool isLoading = true;
  DocumentSnapshot<Object?>? user;

  @override
  void initState() {
    super.initState();
    _readUser();
  }

  _readUser() async {
    UserService userService = context.read<UserService>();
    try {
      await userService.readUser();
    } finally {
      user = userService.user;
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
    UserService userService = context.read<UserService>();
    return Scaffold(
        appBar: AppBar(
          title: Text(userService.screen == 'myCards'
              ? 'Meus cartões'
              : userService.screen == 'requestedCards'
                  ? 'Cartões solicitados'
                  : ''),
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
                  title: const Text('Conta'),
                  onTap: () =>
                      Navigator.of(context).pushNamed(AppRoutes.ACCOUNT),
                  leading: const Icon(Icons.account_circle_outlined, size: 30),
                  iconColor: Colors.black,
                ),
                ListTile(
                  title: const Text('Meus cartões'),
                  onTap: () => setState(() {
                    userService.screen = "myCards";
                    Navigator.of(context).pop();
                  }),
                  leading: const Icon(Icons.credit_card, size: 30),
                  iconColor: Colors.black,
                ),
                ListTile(
                  title: const Text('Cadastrar cartão'),
                  onTap: () => Navigator.of(context)
                      .pushNamed(AppRoutes.REGISTER_CARD_NAME),
                  leading: const Icon(Icons.add_card, size: 30),
                  iconColor: Colors.black,
                ),
                ListTile(
                  title: const Text('Cartões solicitados'),
                  onTap: () => setState(() {
                    userService.screen = "requestedCards";
                    Navigator.of(context).pop();
                  }),
                  leading:
                      const Icon(MdiIcons.creditCardClockOutline, size: 30),
                  iconColor: Colors.black,
                ),
                ListTile(
                  title: const Text('Solicitar cartão'),
                  onTap: () => Navigator.of(context)
                      .pushNamed(AppRoutes.CREATE_CARD_NAME),
                  leading: const Icon(Icons.add_card, size: 30),
                  iconColor: Colors.black,
                ),
                ListTile(
                  title:
                      const Text('Sair', style: TextStyle(color: Colors.red)),
                  onTap: () => _logout(),
                  leading: const Icon(Icons.logout, size: 30),
                  iconColor: Colors.red,
                )
              ],
            )),
        body: userService.screen == 'myCards'
            ? const MyCards()
            : userService.screen == 'requestedCards'
                ? const RequestedCards()
                : null);
  }
}
