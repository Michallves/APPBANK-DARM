import 'package:appbankdarm/services/admin_service.dart';
import 'package:appbankdarm/services/card_service.dart';

import 'package:appbankdarm/widgets/cartao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appbankdarm/utils/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ListUsers extends StatefulWidget {
  const ListUsers({super.key});

  @override
  State<ListUsers> createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de Usuários',
        ),
        actions: [
          ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.transparent)),
              onPressed: () => null,
              child: const Icon(
                Icons.sort_by_alpha,
                color: Colors.black,
                size: 30,
              )),
          ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.transparent)),
              onPressed: () => null,
              child: const Icon(
                Icons.filter_alt_sharp,
                color: Colors.black,
                size: 30,
              )),
          ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.transparent)),
              onPressed: () => null,
              child: const Icon(
                Icons.filter_alt_sharp,
                color: Colors.black,
                size: 30,
              )),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: context.read<AdminService>().readUsers(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.black),
              );
            } else {
              return ListView.separated(
                  padding: const EdgeInsets.all(10),
                  separatorBuilder: (_, ___) =>
                      const Padding(padding: EdgeInsets.all(10)),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    DocumentSnapshot user = snapshot.data!.docs[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 30,
                        backgroundImage:
                            NetworkImage((user['image']).toString()),
                        child: user['image'] == ''
                            ? Text(
                                (user['name'])
                                    .toString()
                                    .substring(0, 2)
                                    .toUpperCase(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 25))
                            : null,
                      ),
                      title: Text(user['name']),
                      subtitle: Text(user['cpf']),
                    );
                  }));
            }
          }),
    );
  }
}
