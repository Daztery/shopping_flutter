import 'package:hive/hive.dart';
import 'package:shopping/features/purchases/data/models/purchase_model.dart';

abstract class PurchaseLocalDataSource {
  Stream<List<PurchaseModel>> getAll();
  Future<void> add(PurchaseModel purchase);
  Future<void> delete(String id);
  Future<void> clear();
}

class PurchaseLocalDatasourceImpl implements PurchaseLocalDataSource {
  static const boxName = 'purchases_box';

  final Box<PurchaseModel> box;
  PurchaseLocalDatasourceImpl(this.box);

  @override
  Stream<List<PurchaseModel>> getAll() async* {
    yield box.values.toList();
    yield* box.watch().map((_) => box.values.toList());
  }

  @override
  Future<void> add(PurchaseModel purchase) async {
    await box.put(purchase.id, purchase);
  }

  @override
  Future<void> delete(String id) async {
    await box.delete(id);
  }

  @override
  Future<void> clear() async {
    await box.clear();
  }
}
