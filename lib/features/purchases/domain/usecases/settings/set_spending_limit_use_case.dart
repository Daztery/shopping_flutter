import 'package:shopping/features/purchases/domain/repositories/settings_repository.dart';

class SetSpendingLimitUseCase {
  final SettingsRepository repo;
  SetSpendingLimitUseCase(this.repo);
  Future<void> call(double? value) => repo.setSpendingLimit(value);
}
