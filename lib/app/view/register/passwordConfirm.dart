import 'package:appbankdarm/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/bottom_button.dart';
import '../widgets/pin.dart';

class RegisterPasswordConfirm extends StatelessWidget {
  RegisterPasswordConfirm({super.key});
  final AuthController controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'senha novamente',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 40),
                  child: Pin(
                    textEditingController:
                        controller.confirmPasswordTextController,
                  )),
            ),
            Obx(() => BottomButtom(
                  onPress: () => null,
                  title: 'criar conta',
                  enabled: controller.isButtonActive.value,
                  loading: controller.isLoading.value,
                ))
          ],
        ),
      ),
    );
  }
}
