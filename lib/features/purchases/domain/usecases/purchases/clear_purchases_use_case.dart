import 'package:dartz/dartz.dart';
import 'package:shopping/features/purchases/domain/repositories/purchase_repository.dart';

class ClearPurchasesUseCase {
  final PurchaseRepository repo;
  ClearPurchasesUseCase(this.repo);
  Future<Either<Exception, void>> call() => repo.clear();
}
