final class AddressEntity {
  final String street;
  final String number;
  final String neighborhood;
  final String city;
  final String state;
  final String zipCode;

  const AddressEntity({
    required this.street,
    required this.number,
    required this.neighborhood,
    required this.city,
    required this.state,
    required this.zipCode,
  });

  factory AddressEntity.fromMap(Map<String, dynamic> map) {
    return AddressEntity(
      street: map[kKeyStreet],
      number: map[kKeyNumber],
      neighborhood: map[kKeyNeighborhood],
      city: map[kKeyCity],
      state: map[kKeyState],
      zipCode: map[kKeyZipCode],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      kKeyStreet: street,
      kKeyNumber: number,
      kKeyNeighborhood: neighborhood,
      kKeyCity: city,
      kKeyState: state,
      kKeyZipCode: zipCode,
    };
  }

  static const String kKeyStreet = 'rua';
  static const String kKeyNumber = 'numero';
  static const String kKeyNeighborhood = 'bairro';
  static const String kKeyCity = 'cidade';
  static const String kKeyState = 'estado';
  static const String kKeyZipCode = 'cep';
}