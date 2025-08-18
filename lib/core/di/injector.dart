import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:shopping/features/purchases/data/datasources/purchase_local_datasource.dart';
import 'package:shopping/features/purchases/data/models/purchase_model.dart';
import 'package:shopping/features/purchases/data/repositories/purchase_repository_impl.dart';
import 'package:shopping/features/purchases/domain/repositories/purchase_repository.dart';
import 'package:shopping/features/purchases/domain/usecases/add_purchase_use_case.dart';
import 'package:shopping/features/purchases/domain/usecases/clear_purchases_use_case.dart';
import 'package:shopping/features/purchases/domain/usecases/delete_purchase_use_case.dart';
import 'package:shopping/features/purchases/domain/usecases/get_all_purchases_use_case.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  await Hive.initFlutter();

  Hive.registerAdapter(PurchaseModelAdapter());

  final purchasesBox = await Hive.openBox<PurchaseModel>('purchases_box');

  // DataSource
  sl.registerLazySingleton<PurchaseLocalDataSource>(
    () => PurchaseLocalDatasourceImpl(purchasesBox),
  );

  // Repository
  sl.registerLazySingleton<PurchaseRepository>(
    () => PurchaseRepositoryImpl(sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => GetAllPurchasesUseCase(sl()));
  sl.registerLazySingleton(() => AddPurchaseUseCase(sl()));
  sl.registerLazySingleton(() => DeletePurchaseUseCase(sl()));
  sl.registerLazySingleton(() => ClearPurchasesUseCase(sl()));
}
