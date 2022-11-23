import 'package:appbankdarm/app/controllers/auth_controller.dart';
import 'package:appbankdarm/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Preload extends StatelessWidget {
  Preload({super.key});
  final AuthController controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Column(children: [
                  Container(
                    width: double.infinity,
                    height: 50,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: ElevatedButton(
                      onPressed: () => {
                        controller.role.value = 'user',
                        Navigator.of(context).pushNamed(Routes.LOGIN_CPF)
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
                        controller.role.value = 'user';
                        Navigator.of(context).pushNamed(Routes.REGISTER_CPF);
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        side: MaterialStateProperty.all(
                          const BorderSide(
                            width: 2,
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
                      controller.role.value = 'admin',
                      Navigator.of(context).pushNamed(Routes.LOGIN_CPF)
                    },
                    style: const ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(Colors.black),
                    ),
                    child: const Text(
                      'entrar admin',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
