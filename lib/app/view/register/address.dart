import 'package:appbankdarm/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../utils/states.dart';
import '../widgets/bottom_button.dart';

class RegisterAddress extends StatelessWidget {
  RegisterAddress({super.key});

  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Endereço',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      DropdownButton(
                          dropdownColor: Colors.white,
                          focusColor: Colors.transparent,
                          hint: const Text(
                            'Estado',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          itemHeight: 70,
                          isExpanded: true,
                          value: controller.state,
                          items: states.map((state) {
                            return DropdownMenuItem(
                              value: state,
                              child: Text(state),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                           
                              controller.state = newValue.toString();
                          
                          }),
                      TextFormField(
                        controller: controller.cityTextController,
                        style: const TextStyle(fontSize: 26),
                        decoration: const InputDecoration(
                            labelText: 'Cidade',
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            border: UnderlineInputBorder()),
                        cursorColor: Colors.black,
                        textInputAction: TextInputAction.next,
                      ),
                      TextFormField(
                        controller: controller.districtTextController,
                        style: const TextStyle(fontSize: 26),
                        decoration: const InputDecoration(
                          labelText: 'Bairro',
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          border: UnderlineInputBorder(),
                        ),
                        cursorColor: Colors.black,
                        textInputAction: TextInputAction.next,
                      ),
                      TextFormField(
                        controller: controller.streetTextController,
                        style: const TextStyle(fontSize: 26),
                        decoration: const InputDecoration(
                          labelText: 'Rua',
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          border: UnderlineInputBorder(),
                        ),
                        cursorColor: Colors.black,
                        textInputAction: TextInputAction.next,
                      ),
                      TextFormField(
                        controller: controller.numberTextController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        style: const TextStyle(fontSize: 26),
                        decoration: const InputDecoration(
                          labelText: 'Número',
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          border: UnderlineInputBorder(),
                        ),
                        cursorColor: Colors.black,
                        textInputAction: TextInputAction.done,
                      ),
                    ],
                  ),
                ),
              ),
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
