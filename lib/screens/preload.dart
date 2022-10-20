import 'package:appbankdarm/utils/app_routes.dart';
import 'package:flutter/material.dart';

class Preload extends StatefulWidget {
  const Preload({super.key});
  @override
  State<Preload> createState() => _PreloadState();
}

class _PreloadState extends State<Preload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Flexible(
              flex: 3,
              child: Container(
                color: Colors.black,
                child: const Center(
                  child: Text(
                    'APPBANK',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                          onPressed: () => {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.LOGIN_CPF_USER)
                          },
                          child: const Text("Entrar"),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context)
                              .pushNamed(AppRoutes.REGISTER_CPF_USER),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            side: MaterialStateProperty.all(
                              const BorderSide(
                                width: 3,
                              ),
                            ),
                            elevation: ButtonStyleButton.allOrNull(0.0),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          child: const Text(
                            "Criar conta",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => {},
                        style: const ButtonStyle(
                          foregroundColor:
                              MaterialStatePropertyAll(Colors.black),
                        ),
                        child: const Text(
                          'Entrar como admin',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      )
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
