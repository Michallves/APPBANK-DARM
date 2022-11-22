class UserModel {
  String? name;
  String? cpf;
  String? email;
  String? telephone;
  String? accountType;
  String? role;
  String? state;
  Map<String, dynamic>? address;

  UserModel(
      {this.name,
      this.cpf,
      this.email,
      this.telephone,
      this.accountType,
      this.role,
      this.state,
      this.address});
}
