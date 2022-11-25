import 'package:appbankdarm/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/bottom_button.dart';
import '../../../widgets/pin.dart';

class NewPasswordConfirm extends StatelessWidget {
  NewPasswordConfirm({super.key});
  final AuthController controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'confirmar nova senha',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: const Text('digite sua nova senha novamente.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.grey)),
            ),
            Expanded(
              child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Pin(
                    textEditingController: controller.passwordTextController,
                  )),
            ),
            Obx(() => BottomButtom(
                  loading: controller.isLoading.value,
                  onPress: () => null,
                  title: 'alterar senha',
                  enabled: controller.isButtonActive.value,
                ))
          ],
        ),
      ),
    );
  }

 
}
