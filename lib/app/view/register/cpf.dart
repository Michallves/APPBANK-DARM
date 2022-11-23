import 'package:appbankdarm/app/controllers/auth_controller.dart';
import 'package:appbankdarm/app/view/widgets/bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RegisterCpfUser extends StatelessWidget {
  RegisterCpfUser({super.key});
  final AuthController controller = Get.put(AuthController());

  
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.role.value == 'user' ? 'seus dados' : 'criar admin',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(20),
                child: TextFormField(
                  key: controller.formKey,
                  controller: controller.cpfTextController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter()
                  ],
                  autofocus: true,
                  style: const TextStyle(fontSize: 26),
                  decoration: const InputDecoration(
                    hintText: '000.000.000-00',
                    labelText: 'qual seu CPF?',
                    errorStyle: TextStyle(
                      color: Colors.red,
                    ),
                    border: InputBorder.none,
                  ),
                  cursorColor: Colors.black,
                ),
              ),
            ),
            BottomButtom(
              onPress: () => null,
              title: 'continuar',
              enabled: controller.isButtonActive.value,
              loading: controller.isLoading.value,
            )
          ],
        ),
      ),
    );

    
  }
}
