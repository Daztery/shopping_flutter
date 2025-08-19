import 'package:dartz/dartz.dart';
import 'package:shopping/features/purchases/domain/entities/purchase.dart';
import 'package:shopping/features/purchases/domain/repositories/purchase_repository.dart';

class AddPurchaseUseCase {
  final PurchaseRepository repo;
  AddPurchaseUseCase(this.repo);
  Future<Either<Exception, void>> call(Purchase purchase) => repo.add(purchase);
}
