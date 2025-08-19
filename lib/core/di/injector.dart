import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:shopping/features/purchases/data/datasources/purchase_local_datasource.dart';
import 'package:shopping/features/purchases/data/datasources/settings_local_datasource.dart';
import 'package:shopping/features/purchases/data/models/purchase_model.dart';
import 'package:shopping/features/purchases/data/repositories/purchase_repository_impl.dart';
import 'package:shopping/features/purchases/data/repositories/settings_repository_impl.dart';
import 'package:shopping/features/purchases/domain/repositories/purchase_repository.dart';
import 'package:shopping/features/purchases/domain/repositories/settings_repository.dart';
import 'package:shopping/features/purchases/domain/usecases/purchases/add_purchase_use_case.dart';
import 'package:shopping/features/purchases/domain/usecases/purchases/clear_purchases_use_case.dart';
import 'package:shopping/features/purchases/domain/usecases/purchases/delete_purchase_use_case.dart';
import 'package:shopping/features/purchases/domain/usecases/purchases/get_all_purchases_use_case.dart';
import 'package:shopping/features/purchases/domain/usecases/purchases/update_purchase_use_case.dart';
import 'package:shopping/features/purchases/domain/usecases/settings/get_spending_limit_use_case.dart';
import 'package:shopping/features/purchases/domain/usecases/settings/set_spending_limit_use_case.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  await Hive.initFlutter();

  Hive.registerAdapter(PurchaseModelAdapter());

  final purchasesBox = await Hive.openBox<PurchaseModel>('purchases_box');
  final settingsBox = await Hive.openBox('settings_box');

  // DataSource
  sl.registerLazySingleton<PurchaseLocalDataSource>(
    () => PurchaseLocalDatasourceImpl(purchasesBox),
  );

  sl.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSourceImpl(settingsBox),
  );

  // Repository
  sl.registerLazySingleton<PurchaseRepository>(
    () => PurchaseRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => GetAllPurchasesUseCase(sl()));
  sl.registerLazySingleton(() => AddPurchaseUseCase(sl()));
  sl.registerLazySingleton(() => DeletePurchaseUseCase(sl()));
  sl.registerLazySingleton(() => ClearPurchasesUseCase(sl()));
  sl.registerLazySingleton(() => GetSpendingLimitUseCase(sl()));
  sl.registerLazySingleton(() => SetSpendingLimitUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePurchaseUseCase(sl()));
}
