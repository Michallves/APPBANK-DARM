import 'package:appbankdarm/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/bottom_button.dart';
import '../widgets/pin.dart';

class LoginPassword extends StatelessWidget {
 LoginPassword({super.key});
  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'senha',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 40),
                  child: Pin(
                    textEditingController: controller.passwordTextController,
                  )),
            ),
            Container(
                margin: const EdgeInsets.all(20),
                child: TextButton(
                    onPressed: () => controller.forgotPassword(),
                    child: const Text(
                      'recuperar conta',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ))),
           Obx(() =>  BottomButtom(
              onPress: () => controller.loginUser(),
              title: 'entrar',
              enabled: controller.isButtonActive.value,
              loading: controller.isLoading.value,
            ))
          ],
        ),
      ),
    );
  }
}
