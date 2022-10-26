import 'package:appbankdarm/services/auth_service.dart';
import 'package:appbankdarm/utils/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterCardName extends StatefulWidget {
  const RegisterCardName({super.key});

  @override
  State<RegisterCardName> createState() => _RegisterCardNameState();
}

class _RegisterCardNameState extends State<RegisterCardName> {
  bool isButtonActive = false;
  final name = TextEditingController();

  @override
  void initState() {
    super.initState();
    name.addListener(() {
      if (name.text.length > 10) {
        setState(() => isButtonActive = true);
      } else {
        setState(() => isButtonActive = false);
      }
    });
  }

  registerCard() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(context.read<AuthService>().usuario?.uid)
        .update({
      "cards": FieldValue.arrayUnion([
        {'name': name.text}
      ]),
    }).then((_) =>
            Navigator.of(context).pushReplacementNamed(AppRoutes.HOMEUSER));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'cadastrar cartão',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: TextFormField(
                controller: name,
                autofocus: true,
                style: const TextStyle(fontSize: 26),
                decoration: const InputDecoration(
                  labelText: 'nome completo',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  border: InputBorder.none,
                ),
                cursorColor: Colors.black,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 50,
            margin: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: isButtonActive == true ? () => registerCard() : null,
              child: const Text("continuar"),
            ),
          ),
        ],
      ),
    );
  }
}
