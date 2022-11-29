import 'package:appbankdarm/app/models/address_model.dart';

class UserModel {
  String? email;
  String? password;

  String? name;
  String? image;
  String? cpf;
  String? telephone;
  String? accountType;
  String? role;
  AddressModel? address;

  UserModel({
    this.email,
    this.password,

    this.image,
    this.name,
    this.cpf,
    this.telephone,
    this.accountType,
    this.role,
    this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      "image": image,
      "name": name,
      "cpf": cpf,
      "email": email,
      "telephone": telephone,
      "accountType": accountType,
      "role": role,
      "address": address,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      image: json["image"],
      name: json["name"],
      cpf: json["cpf"],
      email: json["email"],
      telephone: json["telephone"],
      accountType: json["accountType"],
      role: json["role"],
      address: json["address"],
    );
  }
}
