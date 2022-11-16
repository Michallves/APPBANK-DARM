import 'package:appbankdarm/services/admin_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
              onPressed: () => setState(() {
                    context.read<AdminService>().filter = "name";
                  }),
              child: const Icon(
                Icons.sort_by_alpha,
                color: Colors.black,
                size: 30,
              )),
          ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.transparent)),
              onPressed: () => setState(() {
                    context.read<AdminService>().filter = "state";
                  }),
              child: const Icon(
                Icons.location_on_outlined,
                color: Colors.black,
                size: 30,
              )),
          ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.transparent)),
              onPressed: () => setState(() {
                    context.read<AdminService>().filter = "cards";
                  }),
              child: const Icon(
                Icons.credit_card,
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
                  separatorBuilder: (_, ___) => const Divider(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    DocumentSnapshot user = snapshot.data!.docs[index];
                    return user['role'] == "user"
                        ? ListTile(
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
                                          color: Colors.white, fontSize: 20))
                                  : null,
                            ),
                            title: Text(user['name']),
                            subtitle: Text(
                                "Estado: ${user['state']}\nCartões: ${user['cards']}"),
                          )
                        : Container();
                  }));
            }
          }),
    );
  }
}
