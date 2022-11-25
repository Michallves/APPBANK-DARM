import 'package:appbankdarm/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../widgets/bottom_button.dart';

class RegisterTelephone extends StatelessWidget {
  RegisterTelephone({super.key});
  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Telefone',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: controller.telephoneTextController,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter()
                  ],
                  style: const TextStyle(fontSize: 26),
                  decoration: const InputDecoration(
                    hintText: '(00) 00000-0000',
                    labelText: 'Telefone',
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
                  onPress: () => null,
                  title: 'continuar',
                  enabled: controller.isButtonActive.value,
                ))
          ],
        ),
      ),
    );
  }
}
