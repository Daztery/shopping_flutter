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
}
