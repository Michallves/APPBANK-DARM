import 'package:appbankdarm/app/controllers/auth_controller.dart';
import 'package:appbankdarm/app/view/widgets/bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterName extends StatelessWidget {
  RegisterName({super.key});
  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'nome',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(20),
                child: TextField(
                  controller: controller.nameTextController,
                  autofocus: true,
                  keyboardType: TextInputType.name,
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
            Obx(() => BottomButtom(
                enabled: controller.isButtonActive.value,
                onPress: () => null,
                title: "Continuar"))
          ],
        ),
      ),
    );
  }
}
