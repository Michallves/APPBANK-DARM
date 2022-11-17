import 'package:appbankdarm/controller/card_service.dart';
import 'package:appbankdarm/widgets/cartao.dart';
import 'package:appbankdarm/widgets/cartao_void.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appbankdarm/utils/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class MyCards extends StatelessWidget {
  const MyCards({super.key});

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
              return GestureDetector(
                  onTap: () => Navigator.of(context)
                      .pushNamed(AppRoutes.REGISTER_CARD_NAME),
                  child: const CartaoVoid());
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
