import 'package:appbankdarm/app/models/user_model.dart';
import 'package:appbankdarm/app/providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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

  readUsers() async {
    List<UserModel> userModelList = [];

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    firestore.collection("users").get().then((user) {
      for (var doc in user.docs) {
        userModelList.add(UserModel.fromJson(doc.data()));
      }
    });
  }

  loginUser() async {
    await authProvider
        .login(
            email: emailTextController.text,
            password: passwordTextController.text)
        .then((value) => Get.toNamed(Routes.HOME_USER));
  }

  registerUser() async {
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
  }

  forgotPassword() async {
    await authProvider.forgotPassword(email: emailTextController.text);
  }
}
