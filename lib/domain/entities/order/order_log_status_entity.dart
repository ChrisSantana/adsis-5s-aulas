
final class OrderLogStatusEntity {
  final String status;
  final DateTime datetime;

  const OrderLogStatusEntity({
    required this.status,
    required this.datetime,
  });

  factory OrderLogStatusEntity.fromMap(Map<String, dynamic> map) {
    return OrderLogStatusEntity(
      status: map[kKeyStatus],
      datetime: DateTime.parse(map[kKeyDatetime]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      kKeyStatus: status,
      kKeyDatetime: datetime.toIso8601String(),
    };
  }

  static const String kKeyStatus = 'status';
  static const String kKeyDatetime = 'data';
}