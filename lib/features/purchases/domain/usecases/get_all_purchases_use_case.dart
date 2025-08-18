import 'package:shopping/features/purchases/domain/entities/purchase.dart';
import 'package:shopping/features/purchases/domain/repositories/purchase_repository.dart';

class GetAllPurchasesUseCase {
  final PurchaseRepository repo;
  GetAllPurchasesUseCase(this.repo);
  Stream<List<Purchase>> call() => repo.getAll();
}
