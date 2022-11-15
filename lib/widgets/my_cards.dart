import 'package:appbankdarm/services/card_service.dart';
import 'package:appbankdarm/widgets/cartao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appbankdarm/utils/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class MyCards extends StatefulWidget {
  const MyCards({super.key});

  @override
  State<MyCards> createState() => _MyCardsState();
}

class _MyCardsState extends State<MyCards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: context.read<CardService>().readCards(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.black),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  'Lista vazia',
                  style: TextStyle(color: Colors.grey),
                ),
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
                        context.read<CardService>().card = card;
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
