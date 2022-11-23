import 'package:appbankdarm/app/providers/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthProvider authProvider = AuthProvider();

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

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

  loginUser() async {
    await authProvider.login(
        email: emailTextController.text, password: passwordTextController.text);
  }

  registerUser() async {
    await authProvider.registerUser(
        email: emailTextController.text,
        password: passwordTextController.text,
        name: nameTextController.text,
        cpf: cpfTextController.text,
        telephone: telephoneTextController.text,
        accountType: accountType,
        state: state,
        city: cityTextController.text,
        district: districtTextController.text,
        street: streetTextController.text,
        number: numberTextController.text);
  }
}
