import 'package:appbankdarm/app/controllers/auth_controller.dart';
import 'package:appbankdarm/app/routes/app_routes.dart';
import 'package:appbankdarm/app/view/widgets/bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginCpf extends StatelessWidget {
  LoginCpf({super.key});

  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              controller.role.value == 'user' ? "entrar" : "entrar admin")),
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
                    validator: (value) {
                      return controller.validatorCpf(value!);
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
                  )),
            ),
            controller.role.value == 'admin'
                ? Container(
                    margin: const EdgeInsets.all(20),
                    child: TextButton(
                        onPressed: () => Get.toNamed(Routes.REGISTER_CPF),
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
                onPress: () => controller.validator(),
                title: 'continuar')
          ],
        ),
      ),
    );
  }
}
