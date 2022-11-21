class Usuario {
  String? name;
  String? cpf;
  String? email;
  String? telephone;
  String? accountType;
  String? state;
  Map<String, dynamic>? address;

  Usuario(
      {this.name,
      this.cpf,
      this.email,
      this.telephone,
      this.accountType,
      this.state,
      this.address});
}
