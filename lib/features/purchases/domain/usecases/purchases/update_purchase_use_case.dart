import 'package:dartz/dartz.dart';
import 'package:shopping/features/purchases/domain/entities/purchase.dart';
import 'package:shopping/features/purchases/domain/repositories/purchase_repository.dart';

class UpdatePurchaseUseCase {
  final PurchaseRepository repo;
  UpdatePurchaseUseCase(this.repo);
  Future<Either<Exception, void>> call(Purchase purchase) =>
      repo.update(purchase);
}
