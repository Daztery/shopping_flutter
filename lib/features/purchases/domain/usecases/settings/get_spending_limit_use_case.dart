import 'package:shopping/features/purchases/domain/repositories/settings_repository.dart';

class GetSpendingLimitUseCase {
  final SettingsRepository repo;
  GetSpendingLimitUseCase(this.repo);
  Future<double?> call() => repo.getSpendingLimit();
}
