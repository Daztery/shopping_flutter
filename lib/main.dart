import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/core/di/injector.dart';
import 'package:shopping/features/purchases/domain/usecases/purchases/add_purchase_use_case.dart';
import 'package:shopping/features/purchases/domain/usecases/purchases/clear_purchases_use_case.dart';
import 'package:shopping/features/purchases/domain/usecases/purchases/delete_purchase_use_case.dart';
import 'package:shopping/features/purchases/domain/usecases/purchases/get_all_purchases_use_case.dart';
import 'package:shopping/features/purchases/domain/usecases/settings/get_spending_limit_use_case.dart';
import 'package:shopping/features/purchases/domain/usecases/settings/set_spending_limit_use_case.dart';
import 'package:shopping/features/purchases/presentation/purchases/bloc/purchase_bloc.dart';
import 'package:shopping/features/purchases/presentation/purchases/bloc/purchase_event.dart';
import 'package:shopping/features/purchases/presentation/purchases/view/purchases_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Purchases',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => PurchaseBloc(
          getAllPurchasesUseCase: sl<GetAllPurchasesUseCase>(),
          addPurchaseUseCase: sl<AddPurchaseUseCase>(),
          deletePurchaseUseCase: sl<DeletePurchaseUseCase>(),
          clearPurchasesUseCase: sl<ClearPurchasesUseCase>(),
          getSpendingLimitUseCase: sl<GetSpendingLimitUseCase>(),
          setSpendingLimitUseCase: sl<SetSpendingLimitUseCase>(),
        )..add(const PurchaseStarted()),
        child: const PurchasesPage(),
      ),
    );
  }
}
