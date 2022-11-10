import 'package:appbankdarm/utils/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  void initState() {
    _authChange();
    super.initState();
  }

  _authMode(user) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((doc) => doc.get('type') == 'user'
            ? Navigator.of(context).pushNamed(AppRoutes.HOME_USER)
            : Navigator.of(context).pushNamed(AppRoutes.HOME_ADMIN));
  }

  _authChange() async {
    await FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.of(context).pushNamed(AppRoutes.PRELOAD);
      } else {
        _authMode(user);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(
            color: Colors.white,
          ),
          SizedBox(height: 20),
          Text('Carregando...')
        ],
      )),
    );
  }
}
