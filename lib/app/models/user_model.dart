class UserModel {
  String? image;
  String? name;
  String? cpf;
  String? email;
  String? telephone;
  String? accountType;
  String? role;
  String? state;
  Map<String, dynamic>? address;

  UserModel({
    this.image,
    this.name,
    this.cpf,
    this.email,
    this.telephone,
    this.accountType,
    this.role,
    this.state,
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
      "state": state,
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
      state: json["state"],
      address: json["address"],
    );
  }
}
