final class OrderItemEntity {
  final String produto;
  final int quantidade;
  final double precoUnitario;
  final double subtotal;

  const OrderItemEntity({
    required this.produto,
    required this.quantidade,
    required this.precoUnitario,
    required this.subtotal,
  });

  factory OrderItemEntity.fromMap(Map<String, dynamic> map) {
    return OrderItemEntity(
      produto: map[kKeyProduto],
      quantidade: map[kKeyQuantidade],
      precoUnitario: map[kKeyPrecoUnitario],
      subtotal: map[kKeySubtotal],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      kKeyProduto: produto,
      kKeyQuantidade: quantidade,
      kKeyPrecoUnitario: precoUnitario,
      kKeySubtotal: subtotal,
    };
  }

  static const String kKeyProduto = 'produto';
  static const String kKeyQuantidade = 'quantidade';
  static const String kKeyPrecoUnitario = 'preco_unitario';
  static const String kKeySubtotal = 'subtotal';
}