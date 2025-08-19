import 'package:equatable/equatable.dart';
import 'package:shopping/features/purchases/domain/entities/purchase.dart';

class PurchaseState extends Equatable {
  final List<Purchase> items;
  final bool loading;
  final String? error;
  final double? spendingLimit;

  const PurchaseState({
    this.items = const [],
    this.loading = false,
    this.error,
    this.spendingLimit,
  });

  double get total => items.fold(0.0, (p, e) => p + e.subtotal);
  bool get isOverLimit =>
      spendingLimit != null ? total > spendingLimit! : false;
  double? get remaining =>
      spendingLimit != null ? (spendingLimit! - total) : null;

  PurchaseState copyWith({
    List<Purchase>? items,
    bool? loading,
    String? error,
    double? spendingLimit,
    bool keepLimit = false,
    bool setSpendingLimit = false,
  }) {
    final nextLimit = setSpendingLimit
        ? spendingLimit
        : (keepLimit
            ? this.spendingLimit
            : (spendingLimit ?? this.spendingLimit));
    return PurchaseState(
        items: items ?? this.items,
        loading: loading ?? this.loading,
        error: error,
        spendingLimit: nextLimit);
  }

  @override
  List<Object?> get props => [items, loading, error, spendingLimit];
}
