import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

initConfigurations() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Get.lazyPut<AuthController>(() => AuthController());
}
