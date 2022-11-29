import 'package:appbankdarm/app/models/address_model.dart';
import 'package:appbankdarm/app/models/user_model.dart';
import 'package:appbankdarm/app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';

class AuthController extends GetxController {
  final AuthService authService = AuthService();

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  final nameTextController = TextEditingController();
  final cpfTextController = TextEditingController();
  final telephoneTextController = TextEditingController();
  late String state;
  final cityTextController = TextEditingController();
  final districtTextController = TextEditingController();
  final streetTextController = TextEditingController();
  final numberTextController = TextEditingController();
  late String accountType;

  final formKey = GlobalKey<FormState>();
  var role = 'user'.obs;
  var isLoading = false.obs;
  var isButtonActive = false.obs;

  showSnack(String title, String message) {
    Get.snackbar(title, message,
        backgroundColor: Colors.black,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP);
  }

  loginUser() async {
    try {
      await AuthService.to
          .login(
              email: emailTextController.text,
              password: passwordTextController.text)
          .then((_) => Get.toNamed(Routes.HOME_USER));
    } on FirebaseAuthException catch (erro) {
      showSnack('Erro no login!', erro.message!);
    }
  }

  registerUser() async {
    try {
      await AuthService.to.registerUser(
        user: UserModel(
            email: emailTextController.text,
            name: nameTextController.text,
            cpf: cpfTextController.value.text,
            telephone: telephoneTextController.text,
            accountType: accountType,
            address: AddressModel(
                state: state,
                city: cityTextController.text,
                district: districtTextController.text,
                street: streetTextController.text,
                number: numberTextController.text)),
        password: passwordTextController.text,
      );
    } on FirebaseAuthException catch (erro) {
      showSnack('Erro ao registrar!', erro.message!);
    }
  }

  forgotPassword() async {
    try {
      await AuthService.to.forgotPassword(email: emailTextController.text);
    } on FirebaseAuthException catch (erro) {
      showSnack('Erro ao sair!', erro.message!);
    }
  }

  getEmail() async {
    isLoading.value = true;
    print(await AuthService.to.getEmail(cpfTextController.value.text));
    isLoading.value = false;
  }

  validator() {
    final isValid = formKey.currentState?.validate();
    if (isValid!) {
      return;
    }
    formKey.currentState?.save();
  }

  String? validatorCpf(String value) {
    if (GetUtils.isCpf(value)) {
      return 'ksfdgerger';
    } else {
      return null;
    }
  }
}
