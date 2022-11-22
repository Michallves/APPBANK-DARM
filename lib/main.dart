import 'package:appbankdarm/app/routes/app_pages.dart';
import 'package:appbankdarm/app/services/admin_service.dart';
import 'package:appbankdarm/app/services/auth_service.dart';
import 'package:appbankdarm/app/services/card_service.dart';
import 'package:appbankdarm/app/services/user_service.dart';
import 'package:appbankdarm/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'app/routes/app_routes.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(
            create: (context) =>
                UserService(auth: context.read<AuthService>())),
        ChangeNotifierProvider(
            create: (context) =>
                CardService(auth: context.read<AuthService>())),
        ChangeNotifierProvider(
            create: (context) =>
                AdminService(auth: context.read<AuthService>())),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'APPBANK',
        theme: appThemeData,
        getPages: AppPages.routes,
        initialRoute: Routes.PRELOAD,
      )));
}
