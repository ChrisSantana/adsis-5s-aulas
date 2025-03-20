
import 'package:collection/collection.dart';
import 'package:order_manager/domain/entities/core/address_entity.dart';
import 'package:order_manager/domain/entities/order/order_log_status_entity.dart';
import 'package:order_manager/domain/entities/order/order_item_entity.dart';

enum PayTypeEnum {
  none,
  cash,
  pix,
  creditCard,
  debitCard,
}

final class OrderEntity {
  final int id;
  final DateTime data;
  final String status;
  final double total;
  final PayTypeEnum payType;
  final AddressEntity deliveryAddress;
  final List<OrderItemEntity> itens;
  final List<OrderLogStatusEntity> logStatus;

  const OrderEntity({
    required this.id,
    required this.data,
    required this.status,
    required this.itens,
    required this.total,
    required this.payType,
    required this.deliveryAddress,
    required this.logStatus,
  });

  factory OrderEntity.fromMap(Map<String, dynamic> map) {
    return OrderEntity(
      id: map[kKeyId],
      data: DateTime.parse(map[kKeyData]),
      status: map[kKeyStatus],
      total: map[kKeyTotal],
      payType: (map[kKeyFormaPagamento] as String).toFormaPagamentoEnum(),
      deliveryAddress: AddressEntity.fromMap(map[kKeyEnderecoEntrega]),
      itens: (map[kKeyItens] as List).map((map) => OrderItemEntity.fromMap(map)).toList(),
      logStatus: (map[kKeyHistoricoStatus] as List).map<OrderLogStatusEntity>((map) => OrderLogStatusEntity.fromMap(map)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      kKeyId: id,
      kKeyData: data.toIso8601String(),
      kKeyStatus: status,
      kKeyTotal: total,
      kKeyFormaPagamento: payType.toShortString(),
      kKeyEnderecoEntrega: deliveryAddress.toMap(),
      kKeyItens: itens.map((item) => item.toMap()).toList(),
      kKeyHistoricoStatus: logStatus.map((status) => status.toMap()).toList(),
    };
  }

  static const String kKeyId = 'id';
  static const String kKeyData = 'data';
  static const String kKeyStatus = 'status';
  static const String kKeyItens = 'itens';
  static const String kKeyTotal = 'total';
  static const String kKeyFormaPagamento = 'forma_pagamento';
  static const String kKeyEnderecoEntrega = 'endereco_entrega';
  static const String kKeyHistoricoStatus = 'historico_status';
}

extension _FormaPagamentoExtension on PayTypeEnum {
  String toShortString() {
    return toString().split('.').last;
  }
}

extension _StringExtension on String {
 PayTypeEnum toFormaPagamentoEnum() {
    return PayTypeEnum.values.firstWhereOrNull((value) => value.toShortString().toLowerCase() == toLowerCase()) ?? PayTypeEnum.none;
  }
}