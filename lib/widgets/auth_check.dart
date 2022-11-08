import 'package:appbankdarm/screens/loading.dart';
import 'package:appbankdarm/services/user_service.dart';
import 'package:appbankdarm/utils/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../screens/preload.dart';
import '../screens/user/home.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.of(context).pushNamed(AppRoutes.PRELOAD);
      } else {
        Navigator.of(context).pushNamed(AppRoutes.HOMEUSER);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Loading();
  }
}
