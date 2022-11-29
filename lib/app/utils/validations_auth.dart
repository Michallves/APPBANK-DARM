import 'package:appbankdarm/app/services/auth_service.dart';
import 'package:get/get.dart';

mixin ValidationsMixin {
  String? isNotEmpty(String value) {
    if (value.isEmpty) return "Este campo é obrigatário";
    return null;
  }

  String? isCpfValid(String value) {
    if (GetUtils.isCpf(value)) {
      return "CPF inválido. confira e tente novamente";
    }
    return null;
  }

  String? isCpfBD(String value) {
    if (AuthService.to.getEmail(value) == null) {
      return "CPF não encontrado. confira e tente novamente";
    }
    return null;
  }

  String? isNameValid(String value) {
    if (GetUtils.isUsername(value)) {
      return "Nome inválido. confira e tente novamente";
    }
    return null;
  }

  String? isEmailValid(String value) {
    if (GetUtils.isEmail(value)) {
      return "Email inválido. confira e tente novamente";
    }
    return null;
  }
}
