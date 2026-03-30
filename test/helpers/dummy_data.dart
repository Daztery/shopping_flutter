import 'package:shopping/features/purchases/domain/entities/purchase.dart';

Purchase p1() => Purchase(
      id: '1',
      name: 'Rice',
      quantity: 2,
      unitPrice: 3.5,
      createdAt: DateTime(2025, 1, 1),
    );

Purchase p2() => Purchase(
      id: '2',
      name: 'Milk',
      quantity: 1,
      unitPrice: 4.2,
      createdAt: DateTime(2025, 1, 2),
    );
