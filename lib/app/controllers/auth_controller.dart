import 'package:appbankdarm/app/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';

class AuthController extends GetxController {
  final AuthProvider authProvider = AuthProvider();

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  final nameTextController = TextEditingController();
  var cpfTextController = TextEditingController();
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
      await authProvider
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
      await authProvider.registerUser(
          email: emailTextController.text,
          password: passwordTextController.text,
          name: nameTextController.text,
          cpf: cpfTextController.value.text,
          telephone: telephoneTextController.text,
          accountType: accountType,
          state: state,
          city: cityTextController.text,
          district: districtTextController.text,
          street: streetTextController.text,
          number: numberTextController.text);
    } on FirebaseAuthException catch (erro) {
      showSnack('Erro ao registrar!', erro.message!);
    }
  }

  forgotPassword() async {
    try {
      await authProvider.forgotPassword(email: emailTextController.text);
    } on FirebaseAuthException catch (erro) {
      showSnack('Erro ao sair!', erro.message!);
    }
  }

  getEmail() async {
    isLoading.value = true;

    await authProvider.getEmail(cpfTextController.text).then((email) {});
    print(authProvider.getEmail(cpfTextController.text).toString());
    isLoading.value = false;
  }
}
