import 'package:appbankdarm/services/auth_service.dart';
import 'package:appbankdarm/models/user_repository.dart';
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
        create: (context) => UserRepository(auth: context.read<AuthService>())),
  ], child: const AppBank()));
}
