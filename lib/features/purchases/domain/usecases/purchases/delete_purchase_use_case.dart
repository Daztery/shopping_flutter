import 'package:dartz/dartz.dart';
import 'package:shopping/features/purchases/domain/repositories/purchase_repository.dart';

class DeletePurchaseUseCase {
  final PurchaseRepository repo;
  DeletePurchaseUseCase(this.repo);
  Future<Either<Exception, void>> call(String id) => repo.delete(id);
}
