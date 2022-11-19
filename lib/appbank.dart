import 'package:appbankdarm/view/user/config/changePassword/current_password.dart';
import 'package:appbankdarm/view/user/config/changePassword/new_password.dart';
import 'package:appbankdarm/view/user/config/changePassword/new_password_confirm.dart';
import 'package:appbankdarm/view/admin/card_admin.dart';
import 'package:appbankdarm/view/user/card_user.dart';
import 'package:appbankdarm/view/admin/home_admin.dart';
import 'package:appbankdarm/view/admin/list_users.dart';
import 'package:appbankdarm/view/user/config/config.dart';
import 'package:appbankdarm/view/user/requested_card.dart';
import 'package:flutter/material.dart';
import 'package:appbankdarm/utils/app_routes.dart';
//Routes
import 'view/preload.dart';
//Pages Login User
import 'view/login/cpf.dart';
import 'view/login/password.dart';
//Pages Register User
import 'view/register/cpf.dart';
import 'view/register/name.dart';
import 'view/register/email.dart';
import 'view/register/telephone.dart';
import 'view/register/address.dart';
import 'view/register/accountType.dart';
import 'view/register/password.dart';
import 'view/register/passwordConfirm.dart';
//Pages Home User
import 'package:appbankdarm/view/user/home_user.dart';
//Pages Account User
import 'view/user/account.dart';
import 'view/user/config/delete.dart';
//Pages Create Card User
import 'view/user/request_card/name.dart';
import 'view/user/request_card/type.dart';
import 'view/user/request_card/flag.dart';
import 'view/user/request_card/validity.dart';
//Pages Register Card User
import 'view/user/register_card/name.dart';
import 'view/user/register_card/number.dart';
import 'view/user/register_card/cvc.dart';
import 'view/user/register_card/validity.dart';

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
        inputDecorationTheme: const InputDecorationTheme(
            floatingLabelStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        )),
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
        AppRoutes.PRELOAD: (ctx) => const Preload(),
        //Login User
        AppRoutes.LOGIN_CPF: (ctx) => const LoginCpfUser(),
        AppRoutes.LOGIN_PASSWORD: (ctx) => const LoginPasswordUser(),
        //Register User
        AppRoutes.REGISTER_CPF: (ctx) => const RegisterCpfUser(),
        AppRoutes.REGISTER_NAME: (ctx) => const RegisterNameUser(),
        AppRoutes.REGISTER_EMAIL: (ctx) => const RegisterEmailUser(),
        AppRoutes.REGISTER_TELEPHONE: (ctx) => const RegisterTelephoneUser(),
        AppRoutes.REGISTER_ADDRESS: (ctx) => const RegisterAddressUser(),
        AppRoutes.REGISTER_ACCOUNT_TYPE: (ctx) =>
            const RegisterAccountTypeUser(),
        AppRoutes.REGISTER_PASSWORD: (ctx) => const RegisterPassword(),
        AppRoutes.REGISTER_PASSWORD_CONFIRM: (ctx) =>
            const RegisterPasswordConfirm(),
        //Home User
        AppRoutes.HOME_USER: (ctx) => const HomeUser(),
        AppRoutes.CARD_USER: (ctx) => const CardUser(),
        AppRoutes.REQUESTED_CARD: (ctx) => const RequestedCard(),
        //Account User
        AppRoutes.ACCOUNT: (ctx) => const AccountUser(),
        AppRoutes.CONFIG_USER: (ctx) => const ConfigUser(),
        AppRoutes.DELETE: (ctx) => const DeleteUser(),
        //Change Password User
        AppRoutes.CURRENT_PASSWORD: (ctx) => const CurrentPassword(),
        AppRoutes.NEW_PASSWORD: (ctx) => const NewPassword(),
        AppRoutes.NEW_PASSWORD_CONFIRM: (ctx) => const NewPasswordConfirm(),
        //Create Card User
        AppRoutes.REQUEST_CARD_NAME: (ctx) => const CreateCardName(),
        AppRoutes.CREATE_CARD_TYPE: (ctx) => const CreateCardType(),
        AppRoutes.CREATE_CARD_FLAG: (ctx) => const CreateCardFlag(),
        AppRoutes.REQUEST_CARD_VALIDITY: (ctx) => const CreateCardValidity(),
        //Register Card User
        AppRoutes.REGISTER_CARD_NAME: (ctx) => const RegisterCardName(),
        AppRoutes.REGISTER_CARD_NUMBER: (ctx) => const RegisterCardNumber(),
        AppRoutes.REGISTER_CARD_CVC: (ctx) => const RegisterCardCvc(),
        AppRoutes.REGISTER_CARD_VALIDITY: (ctx) => const RegisterCardValidity(),
        //Admin User
        AppRoutes.HOME_ADMIN: (ctx) => const HomeAdmin(),
        AppRoutes.CARD_ADMIN: (ctx) => const CardAdmin(),
        AppRoutes.LIST_USERS: (ctx) => const ListUsers(),
      },
    );
  }
}
