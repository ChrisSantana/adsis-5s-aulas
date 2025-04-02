final class LocationEntity {
  final String code;
  final double latitude;
  final double longitude;

  const LocationEntity({
    required this.code,
    required this.latitude,
    required this.longitude,
  });

  factory LocationEntity.fromMap(Map<String, dynamic> map) {
    return LocationEntity(
      code: map[kKeyCode],
      latitude: (map[kKeyLatitude] as num).toDouble(),
      longitude: (map[kKeyLongitude] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      kKeyCode: code,
      kKeyLatitude: latitude,
      kKeyLongitude: longitude,
    };
  }

  static const String kKeyCode = 'codigo';
  static const String kKeyLatitude = 'latitude';
  static const String kKeyLongitude = 'longitude';
}
