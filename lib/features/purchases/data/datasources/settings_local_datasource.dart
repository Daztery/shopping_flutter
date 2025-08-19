import 'package:hive/hive.dart';

abstract class SettingsLocalDataSource {
  Future<double?> getSpendingLimit();
  Future<void> saveLimit(double? value);
  Future<void> removeLimit();
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  static const boxName = 'settings_box';
  static const keyLimit = 'spending_limit';

  final Box box;
  SettingsLocalDataSourceImpl(this.box);

  @override
  Future<double?> getSpendingLimit() async {
    final v = box.get(keyLimit);
    if (v == null) return null;
    return (v as num).toDouble();
  }

  @override
  Future<void> saveLimit(double? value) async {
    await box.put(keyLimit, value);
  }

  @override
  Future<void> removeLimit() async {
    await box.delete(keyLimit);
  }
}
