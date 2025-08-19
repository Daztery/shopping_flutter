class Purchase {
  final String id;
  final String name;
  final int quantity;
  final double unitPrice;
  final DateTime createdAt;

  const Purchase({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unitPrice,
    required this.createdAt,
  });

  double get subtotal => quantity * unitPrice;

  Purchase copyWith({
    String? id,
    String? name,
    int? quantity,
    double? unitPrice,
    DateTime? createdAt,
  }) {
    return Purchase(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
