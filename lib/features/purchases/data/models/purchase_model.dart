import 'package:hive/hive.dart';
import 'package:shopping/features/purchases/domain/entities/purchase.dart';

part 'purchase_model.g.dart';

@HiveType(typeId: 1)
class PurchaseModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  int quantity;

  @HiveField(3)
  double unitPrice;

  @HiveField(4)
  DateTime createdAt;

  PurchaseModel({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unitPrice,
    required this.createdAt,
  });

  Purchase toEntity() => Purchase(
        id: id,
        name: name,
        quantity: quantity,
        unitPrice: unitPrice,
        createdAt: createdAt,
      );

  factory PurchaseModel.fromEntity(Purchase e) => PurchaseModel(
        id: e.id,
        name: e.name,
        quantity: e.quantity,
        unitPrice: e.unitPrice,
        createdAt: e.createdAt,
      );
}
