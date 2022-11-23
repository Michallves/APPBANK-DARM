import 'package:appbankdarm/app/bindings/auth_binding.dart';
import 'package:get/get.dart';
import '../view/admin/card_admin.dart';
import '../view/admin/home_admin.dart';
import '../view/admin/list_users.dart';
import '../view/login/cpf.dart';
import '../view/login/password.dart';
import '../view/preload.dart';
import '../view/register/accountType.dart';
import '../view/register/address.dart';
import '../view/register/cpf.dart';
import '../view/register/email.dart';
import '../view/register/name.dart';
import '../view/register/password.dart';
import '../view/register/passwordConfirm.dart';
import '../view/register/telephone.dart';
import '../view/user/account.dart';
import '../view/user/card_user.dart';
import '../view/user/config/changePassword/current_password.dart';
import '../view/user/config/changePassword/new_password.dart';
import '../view/user/config/changePassword/new_password_confirm.dart';
import '../view/user/config/config.dart';
import '../view/user/config/delete.dart';
import '../view/user/home_user.dart';
import '../view/user/register_card/cvc.dart';
import '../view/user/register_card/name.dart';
import '../view/user/register_card/number.dart';
import '../view/user/register_card/validity.dart';
import '../view/user/request_card/flag.dart';
import '../view/user/request_card/name.dart';
import '../view/user/request_card/type.dart';
import '../view/user/request_card/validity.dart';
import '../view/user/requested_card.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: Routes.PRELOAD, page: () =>  Preload(), binding: AuthBinding()),
    //Login User
    GetPage(
        name: Routes.LOGIN_CPF,
        page: () => const LoginCpfUser(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.LOGIN_PASSWORD,
        page: () => const LoginPasswordUser(),
        binding: AuthBinding()),
    //Register User
    GetPage(
        name: Routes.REGISTER_CPF,
        page: () => RegisterCpfUser(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.REGISTER_NAME,
        page: () => const RegisterNameUser(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.REGISTER_EMAIL,
        page: () => RegisterEmailUser(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.REGISTER_TELEPHONE,
        page: () => const RegisterTelephoneUser(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.REGISTER_ADDRESS,
        page: () =>  RegisterAddressUser(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.REGISTER_ACCOUNT_TYPE,
        page: () =>  RegisterAccountTypeUser(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.REGISTER_PASSWORD,
        page: () => const RegisterPassword(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.REGISTER_PASSWORD_CONFIRM,
        page: () => const RegisterPasswordConfirm(),
        binding: AuthBinding()),
    //Home User
    GetPage(name: Routes.HOME_USER, page: () => const HomeUser()),
    GetPage(name: Routes.CARD_USER, page: () => const CardUser()),
    GetPage(name: Routes.REQUESTED_CARD, page: () => const RequestedCard()),
    //Account User
    GetPage(name: Routes.ACCOUNT, page: () => const AccountUser()),
    GetPage(name: Routes.CONFIG_USER, page: () => const ConfigUser()),
    GetPage(name: Routes.DELETE, page: () => const DeleteUser()),
    //Change Password User
    GetPage(name: Routes.CURRENT_PASSWORD, page: () => const CurrentPassword()),
    GetPage(name: Routes.NEW_PASSWORD, page: () => const NewPassword()),
    GetPage(
        name: Routes.NEW_PASSWORD_CONFIRM,
        page: () => const NewPasswordConfirm()),
    //Create Card User
    GetPage(name: Routes.REQUEST_CARD_NAME, page: () => const CreateCardName()),
    GetPage(name: Routes.CREATE_CARD_TYPE, page: () => const CreateCardType()),
    GetPage(name: Routes.CREATE_CARD_FLAG, page: () => const CreateCardFlag()),
    GetPage(
        name: Routes.REQUEST_CARD_VALIDITY,
        page: () => const CreateCardValidity()),
    //Register Card User
    GetPage(
        name: Routes.REGISTER_CARD_NAME, page: () => const RegisterCardName()),
    GetPage(
        name: Routes.REGISTER_CARD_NUMBER,
        page: () => const RegisterCardNumber()),
    GetPage(
        name: Routes.REGISTER_CARD_CVC, page: () => const RegisterCardCvc()),
    GetPage(
        name: Routes.REGISTER_CARD_VALIDITY,
        page: () => const RegisterCardValidity()),
    //Admin User
    GetPage(name: Routes.HOME_ADMIN, page: () => const HomeAdmin()),
    GetPage(name: Routes.CARD_ADMIN, page: () => const CardAdmin()),
    GetPage(name: Routes.LIST_USERS, page: () => const ListUsers()),
  ];
}
