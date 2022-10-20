import 'package:appbankdarm/screens/loading.dart';
import 'package:appbankdarm/screens/preload.dart';
import 'package:appbankdarm/screens/user/home.dart';
import 'package:appbankdarm/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    if (auth.isLoading) {
      return const Loading();
    } else if (auth.usuario == null) {
      return const Preload();
    } else {
      return const HomeUser();
    }
  }
}
