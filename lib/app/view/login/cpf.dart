import 'package:appbankdarm/app/controllers/auth_controller.dart';
import 'package:appbankdarm/app/routes/app_routes.dart';
import 'package:appbankdarm/app/view/widgets/bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginCpfUser extends StatelessWidget {
  LoginCpfUser({super.key});

  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar:  AppBar(
            title: Text(
                controller.role.value == 'user' ? 'entrar' : 'entrar admin'),
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
                  textInputAction: TextInputAction.none,
                  keyboardAppearance: Brightness.dark,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter()
                  ],
                  autofocus: true,
                  style: const TextStyle(fontSize: 26),
                  validator: (String? value) {
                    if (GetUtils.isCpf(controller.cpfTextController.text) ==
                            false &&
                        controller.cpfTextController.text.length == 14) {
                      return 'CPF inválido. confira e tente novamente';
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: '000.000.000-00',
                    labelText: 'digite seu CPF',
                    errorStyle: TextStyle(
                      color: Colors.red,
                    ),
                    border: InputBorder.none,
                  ),
                  cursorColor: Colors.black,
                ),
              ),
            ),
            controller.role.value == 'admin'
                ? Container(
                    margin: const EdgeInsets.all(20),
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(Routes.REGISTER_CPF);
                        },
                        child: const Text(
                          'criar conta admin',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )))
                : Container(),
            BottomButtom(
                loading: controller.isLoading.value,
                enabled: controller.isButtonActive.value,
                onPress: () => null,
                title: 'continuar')
          ],
        ),
      ),
    ));
  }

  
}
