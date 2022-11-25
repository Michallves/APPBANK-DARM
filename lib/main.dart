import 'package:appbankdarm/app/routes/app_pages.dart';
import 'package:appbankdarm/app/providers/admin_service.dart';
import 'package:appbankdarm/app/providers/auth_provider.dart';
import 'package:appbankdarm/app/providers/card_service.dart';
import 'package:appbankdarm/app/providers/user_service.dart';
import 'package:appbankdarm/app/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'app/routes/app_routes.dart';
import 'firebase_options.dart';

main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) =>
                UserService(auth: context.read<AuthProvider>())),
        ChangeNotifierProvider(
            create: (context) =>
                CardService(auth: context.read<AuthProvider>())),
        ChangeNotifierProvider(
            create: (context) =>
                AdminService(auth: context.read<AuthProvider>())),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'APPBANK',
        theme: appThemeData,
        initialRoute: Routes.PRELOAD,
        getPages: AppPages.routes,
      )));
}
