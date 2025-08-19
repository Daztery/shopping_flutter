import 'package:shopping/features/purchases/data/datasources/settings_local_datasource.dart';
import 'package:shopping/features/purchases/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource local;
  SettingsRepositoryImpl(this.local);

  @override
  Future<double?> getSpendingLimit() => local.getSpendingLimit();

  @override
  Future<void> setSpendingLimit(double? value) async {
    if (value == null || value == 0.0) {
      await local.removeLimit();
    } else {
      await local.saveLimit(value);
    }
  }
}
