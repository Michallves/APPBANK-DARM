import 'package:appbankdarm/controller/admin_service.dart';
import 'package:appbankdarm/controller/auth_service.dart';
import 'package:appbankdarm/controller/card_service.dart';
import 'package:appbankdarm/controller/user_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'appbank.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AuthService()),
    ChangeNotifierProvider(
        create: (context) => UserService(auth: context.read<AuthService>())),
    ChangeNotifierProvider(
        create: (context) => CardService(auth: context.read<AuthService>())),
    ChangeNotifierProvider(
        create: (context) => AdminService(auth: context.read<AuthService>())),
  ], child: const AppBank()));
}
