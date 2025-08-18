import 'package:equatable/equatable.dart';
import 'package:shopping/features/purchases/domain/entities/purchase.dart';

class PurchaseState extends Equatable {
  final List<Purchase> items;
  final bool loading;
  final String? error;

  const PurchaseState({
    this.items = const [],
    this.loading = false,
    this.error,
  });

  double get total => items.fold(0.0, (p, e) => p + e.subtotal);

  PurchaseState copyWith({
    List<Purchase>? items,
    bool? loading,
    String? error,
  }) {
    return PurchaseState(
      items: items ?? this.items,
      loading: loading ?? this.loading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [items, loading, error];
}
