import 'package:dartz/dartz.dart';
import 'package:shopping/features/purchases/domain/entities/purchase.dart';

abstract class PurchaseRepository {
  Stream<List<Purchase>> getAll();
  Future<Either<Exception, void>> add(Purchase purchase);
  Future<Either<Exception, void>> delete(String id);
  Future<Either<Exception, void>> clear();
  Future<Either<Exception, void>> update(Purchase purchase);
}
