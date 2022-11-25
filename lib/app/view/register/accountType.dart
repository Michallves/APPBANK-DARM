import 'package:appbankdarm/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/bottom_button.dart';

class RegisterAccountType extends StatelessWidget {
  RegisterAccountType({super.key});
  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'tipo de conta',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(children: [
                ListTile(
                  title: const Text('Poupança'),
                  onTap: () => 
                    controller.accountType = 'savings'
                ,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  leading: Radio(
                    value: 'savings',
                    activeColor: Colors.black,
                    groupValue: controller.accountType,
                    onChanged: ((String? value) {
                    
                        controller.accountType = value.toString();
                     
                    }),
                  ),
                ),
                ListTile(
                  title: const Text('Corrente'),
                  onTap: () => 
                    controller.accountType = 'current'
                 ,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  leading: Radio(
                    value: 'current',
                    activeColor: Colors.black,
                    groupValue: controller.accountType,
                    onChanged: ((String? value) {
                     
                        controller.accountType = value.toString();
                     
                    }),
                  ),
                ),
              ]),
            ),
            BottomButtom(
              onPress: () => null,
              title: 'continuar',
              enabled: controller.isButtonActive.value,
            )
          ],
        ),
      ),
    );
  }
}
