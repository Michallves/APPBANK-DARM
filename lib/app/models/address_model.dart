class AddressModel {
  final String? state;
  final String? district;
  final String? city;
  final String? street;
  final String? number;

  AddressModel({
    this.state,
    this.district,
    this.city,
    this.street,
    this.number,
  });

  Map<String, dynamic> toJson() {
    return {
      "state": state,
      "district": district,
      "city": city,
      "street": street,
      "number": number,
    };
  }

  
}
