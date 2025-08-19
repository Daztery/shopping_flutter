import 'package:dartz/dartz.dart';
import 'package:shopping/features/purchases/data/datasources/purchase_local_datasource.dart';
import 'package:shopping/features/purchases/data/models/purchase_model.dart';
import 'package:shopping/features/purchases/domain/entities/purchase.dart';
import 'package:shopping/features/purchases/domain/repositories/purchase_repository.dart';

class PurchaseRepositoryImpl implements PurchaseRepository {
  final PurchaseLocalDataSource local;
  PurchaseRepositoryImpl(this.local);

  @override
  Future<Either<Exception, void>> add(Purchase purchase) async {
    try {
      await local.add(PurchaseModel.fromEntity(purchase));
      return const Right(null);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, void>> clear() async {
    try {
      await local.clear();
      return const Right(null);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, void>> delete(String id) async {
    try {
      await local.delete(id);
      return const Right(null);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Stream<List<Purchase>> getAll() =>
      local.getAll().map((list) => list.map((m) => m.toEntity()).toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt)));
}
