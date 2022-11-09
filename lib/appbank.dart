import 'package:appbankdarm/screens/card.dart';
import 'package:appbankdarm/widgets/auth_check.dart';
import 'package:flutter/material.dart';
import 'package:appbankdarm/utils/app_routes.dart';
//Routes
import 'screens/preload.dart';
//Pages Login User
import 'screens/user/login/cpf.dart';
import 'screens/user/login/password.dart';
//Pages Register User
import 'screens/user/register/cpf.dart';
import 'screens/user/register/name.dart';
import 'screens/user/register/email.dart';
import 'screens/user/register/telephone.dart';
import 'screens/user/register/address.dart';
import 'screens/user/register/accountType.dart';
import 'screens/user/register/password.dart';
import 'screens/user/register/passwordAgain.dart';
//Pages Home User
import 'screens/user/home.dart';
//Pages Account User
import 'screens/user/account/profile.dart';
import 'screens/user/account/delete.dart';
//Pages Create Card User
import 'screens/user/create_card/name.dart';
import 'screens/user/create_card/type.dart';
import 'screens/user/create_card/flag.dart';
import 'screens/user/create_card/validity.dart';
//Pages Register Card User
import 'screens/user/register_card/name.dart';
import 'screens/user/register_card/number.dart';
import 'screens/user/register_card/cvc.dart';
import 'screens/user/register_card/validity.dart';

class AppBank extends StatelessWidget {
  const AppBank({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'APPBANK',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0),
        scaffoldBackgroundColor: Colors.white,
        indicatorColor: Colors.black,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      routes: {
        AppRoutes.AUTHCHECK: (ctx) => const AuthCheck(),
        AppRoutes.PRELOAD: (ctx) => const Preload(),
        //Login User
        AppRoutes.LOGIN_CPF_USER: (ctx) => const LoginCpfUser(),
        AppRoutes.LOGIN_PASSWORD_USER: (ctx) => const LoginPasswordUser(),
        //Register User
        AppRoutes.REGISTER_CPF_USER: (ctx) => const RegisterCpfUser(),
        AppRoutes.REGISTER_NAME_USER: (ctx) => const RegisterNameUser(),
        AppRoutes.REGISTER_EMAIL_USER: (ctx) => const RegisterEmailUser(),
        AppRoutes.REGISTER_TELEPHONE_USER: (ctx) =>
            const RegisterTelephoneUser(),
        AppRoutes.REGISTER_ADDRESS_USER: (ctx) => const RegisterAddressUser(),
        AppRoutes.REGISTER_ACCOUNT_TYPE_USER: (ctx) =>
            const RegisterAccountTypeUser(),
        AppRoutes.REGISTER_PASSWORD_USER: (ctx) => const RegisterPasswordUser(),
        AppRoutes.REGISTER_PASSWORD_AGAIN_USER: (ctx) =>
            const RegisterPasswordAgainUser(),
        //Home User
        AppRoutes.HOMEUSER: (ctx) => const HomeUser(),
        AppRoutes.CARD_USER: (ctx) => const CardUser(),
        //Account User
        AppRoutes.ACCOUNT_USER: (ctx) => const AccountUser(),
        AppRoutes.DELETE_USER: (ctx) => const DeleteUser(),
        //Create Card User
        AppRoutes.CREATE_CARD_NAME: (ctx) => const CreateCardName(),
        AppRoutes.CREATE_CARD_TYPE: (ctx) => const CreateCardType(),
        AppRoutes.CREATE_CARD_FLAG: (ctx) => const CreateCardFlag(),
        AppRoutes.CREATE_CARD_VALIDITY: (ctx) => const CreateCardValidity(),
        //Register Card User
        AppRoutes.REGISTER_CARD_NAME: (ctx) => const RegisterCardName(),
        AppRoutes.REGISTER_CARD_NUMBER: (ctx) => const RegisterCardNumber(),
        AppRoutes.REGISTER_CARD_CVC: (ctx) => const RegisterCardCvc(),
        AppRoutes.REGISTER_CARD_VALIDITY: (ctx) => const RegisterCardValidity()
      },
    );
  }
}
