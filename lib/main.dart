import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/core/di/injector.dart';
import 'package:shopping/features/purchases/domain/usecases/purchases/add_purchase_use_case.dart';
import 'package:shopping/features/purchases/domain/usecases/purchases/clear_purchases_use_case.dart';
import 'package:shopping/features/purchases/domain/usecases/purchases/delete_purchase_use_case.dart';
import 'package:shopping/features/purchases/domain/usecases/purchases/get_all_purchases_use_case.dart';
import 'package:shopping/features/purchases/domain/usecases/purchases/update_purchase_use_case.dart';
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

  static const _brandColor = Color(0xFF030567);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mercao',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _brandColor),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: _brandColor,
            foregroundColor: Colors.white,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: _brandColor,
          ),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor: _brandColor,
          ),
        ),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => PurchaseBloc(
          getAllPurchasesUseCase: sl<GetAllPurchasesUseCase>(),
          addPurchaseUseCase: sl<AddPurchaseUseCase>(),
          updatePurchaseUseCase: sl<UpdatePurchaseUseCase>(),
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
