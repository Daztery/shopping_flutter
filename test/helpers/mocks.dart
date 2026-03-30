import 'package:mocktail/mocktail.dart';
import 'package:shopping/features/purchases/domain/entities/purchase.dart';
import 'package:shopping/features/purchases/domain/repositories/purchase_repository.dart';
import 'package:shopping/features/purchases/domain/repositories/settings_repository.dart';
import 'package:shopping/features/purchases/domain/usecases/purchases/add_purchase_use_case.dart';
import 'package:shopping/features/purchases/domain/usecases/purchases/clear_purchases_use_case.dart';
import 'package:shopping/features/purchases/domain/usecases/purchases/delete_purchase_use_case.dart';
import 'package:shopping/features/purchases/domain/usecases/purchases/get_all_purchases_use_case.dart';
import 'package:shopping/features/purchases/domain/usecases/settings/get_spending_limit_use_case.dart';
import 'package:shopping/features/purchases/domain/usecases/settings/set_spending_limit_use_case.dart';

class MockPurchaseRepository extends Mock implements PurchaseRepository {}

class MockSettingsRepository extends Mock implements SettingsRepository {}

class MockGetAllPurchasesUseCase extends Mock
    implements GetAllPurchasesUseCase {}

class MockAddPurchaseUseCase extends Mock implements AddPurchaseUseCase {}

class MockDeletePurchaseUseCase extends Mock implements DeletePurchaseUseCase {}

class MockClearPurchasesUseCase extends Mock implements ClearPurchasesUseCase {}

class MockGetSpendingLimitUseCase extends Mock
    implements GetSpendingLimitUseCase {}

class MockSetSpendingLimitUseCase extends Mock
    implements SetSpendingLimitUseCase {}

class FakePurchase extends Fake implements Purchase {}
