import 'package:appbankdarm/app/services/card_service.dart';
import 'package:appbankdarm/app/view/widgets/cartao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appbankdarm/app/routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../models/card_model.dart';
import 'cartao_void.dart';

class RequestedCards extends StatelessWidget {
  const RequestedCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: context.read<CardService>().readRequestedCards(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.black),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return GestureDetector(
                  onTap: () => Navigator.of(context)
                      .pushNamed(Routes.REGISTER_CARD_NAME),
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
                        Navigator.of(context).pushNamed(Routes.REQUESTED_CARD);
                      },
                      child: CartaoCard(Cartao(
                        number: card['number'],
                        flag: card['flag'],
                        name: card['name'],
                        validity: card['validity'],
                      )),
                    );
                  }));
            }
          }),
    );
  }
}
