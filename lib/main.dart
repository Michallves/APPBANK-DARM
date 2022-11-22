import 'package:appbankdarm/app/routes/app_pages.dart';
import 'package:appbankdarm/app/services/admin_service.dart';
import 'package:appbankdarm/app/services/auth_service.dart';
import 'package:appbankdarm/app/services/card_service.dart';
import 'package:appbankdarm/app/services/user_service.dart';
import 'package:appbankdarm/app/theme/app_theme.dart';
import 'package:appbankdarm/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'app/routes/app_routes.dart';

Future<void> main() async {
  await initConfigurations();

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
