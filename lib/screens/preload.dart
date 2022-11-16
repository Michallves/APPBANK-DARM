import 'package:appbankdarm/services/auth_service.dart';
import 'package:appbankdarm/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Preload extends StatelessWidget {
  const Preload({super.key});
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
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
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
                            context.read<AuthService>().role = 'user',
                            Navigator.of(context).pushNamed(AppRoutes.LOGIN_CPF)
                          },
                          child: const Text("entrar"),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: OutlinedButton(
                          onPressed: () {
                            context.read<AuthService>().role = 'user';
                            Navigator.of(context)
                                .pushNamed(AppRoutes.REGISTER_CPF);
                          },
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
                            "criar conta",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => {
                          context.read<AuthService>().role = 'admin',
                          Navigator.of(context).pushNamed(AppRoutes.LOGIN_CPF)
                        },
                        style: const ButtonStyle(
                          foregroundColor:
                              MaterialStatePropertyAll(Colors.black),
                        ),
                        child: const Text(
                          'entrar admin',
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
