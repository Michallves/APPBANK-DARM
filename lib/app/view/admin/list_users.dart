import 'package:appbankdarm/app/providers/admin_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../models/user_model.dart';

class ListUsers extends StatefulWidget {
  const ListUsers({super.key});

  @override
  State<ListUsers> createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  Future<List<UserModel>> _getUsers() async {
    List<UserModel> userModelList = [];

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    final data = await firestore.collection("users").get();

    for (var user in data.docs) {
      userModelList.add(UserModel.fromJson(user.data()));
    }

    return userModelList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Usuários',
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<Object>(
            stream: _getUsers().asStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return const Center(
                  child: CircularProgressIndicator(),
                );

              List<UserModel> users = snapshot.data as List<UserModel>;
              print(users);

              return ListView.separated(
                padding: const EdgeInsets.all(10),
                separatorBuilder: (_, ___) => const Divider(),
                itemCount: users.length,
                itemBuilder: ((context, index) {
                  UserModel user = users[index];
                  return ListTile(
                    leading: Image.network(
                        "https://commons.wikimedia.org/wiki/Commons:Quality_images#/media/File:Gull_portrait_ca_usa.jpg"),
                    title: Text(user.name!),
                    subtitle: Text("Estado: ${user.state}"),
                  );
                }),
              );
            }),
      ),
    );
  }
}
