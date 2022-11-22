import 'package:flutter/material.dart';

class CartaoVoid extends StatelessWidget {
  const CartaoVoid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        height: (MediaQuery.of(context).size.width - 40) * 0.60,
        decoration: BoxDecoration(
            color: Colors.grey[300],
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.05),
                  blurRadius: 20,
                  spreadRadius: 3)
            ],
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Icon(
            Icons.add,
            size: 100,
            color: Colors.grey[350],
          ),
        ));
  }
}
