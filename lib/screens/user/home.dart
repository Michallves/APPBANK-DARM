import 'package:appbankdarm/services/auth_service.dart';
import 'package:appbankdarm/widgets/bottom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:appbankdarm/widgets/cartao.dart';
import 'package:appbankdarm/utils/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class HomeUser extends StatefulWidget {
  const HomeUser({super.key});

  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  String? name;
  String? image;
  bool isLoading = false;

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(context.read<AuthService>().user?.uid)
        .get()
        .then((doc) =>
            setState(() => {name = doc.get('name'), image = doc.get('image')}));

    super.initState();
  }

  _logout() async {
    await FirebaseAuth.instance.signOut();
  }

  _deleteCard(card) async {
    setState(() {
      isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(context.read<AuthService>().user?.uid)
        .collection('cards')
        .doc(card)
        .delete()
        .then((_) {
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    });
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
                    backgroundImage: NetworkImage(image == null ? '' : image!),
                    child: image == null
                        ? Text(name.toString().substring(0, 2).toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 30))
                        : null,
                  ),
                  Text(name.toString(), style: const TextStyle(fontSize: 18))
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
                onTap: () => _logout(),
                leading: const Icon(Icons.logout, size: 30),
                iconColor: Colors.red,
              )
            ],
          )),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(context.read<AuthService>().user?.uid)
              .collection('cards')
              .snapshots(),
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
                      onLongPress: () => showModal(card),
                      child: Cartao(
                          number: card['number'],
                          flag: card['flag'],
                          name: card['name'],
                          type: card['type'] ?? '',
                          validity: card['validity'],
                          cvc: card['cvc'],
                          obscure: true),
                    );
                  }));
            }
          }),
    );
  }

  void showModal(card) => showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        context: context,
        builder: (context) => SizedBox(
          height: 200,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            BottomButtom(
              onPress: () => _deleteCard(card?.id),
              title: 'excluir cartão',
              color: Colors.redAccent,
              loading: isLoading,
            ),
            BottomButtom(
                onPress: () => Navigator.of(context).pop(),
                title: 'cancelar',
                color: Colors.grey[350])
          ]),
        ),
      );
}
