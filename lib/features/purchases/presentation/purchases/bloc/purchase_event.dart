import 'package:equatable/equatable.dart';

class PurchaseEvent extends Equatable {
  const PurchaseEvent();
  @override
  List<Object?> get props => [];
}

class PurchaseStarted extends PurchaseEvent {
  const PurchaseStarted();
}

class PurchaseAdded extends PurchaseEvent {
  final String name;
  final int quantity;
  final double unitPrice;

  const PurchaseAdded(this.name, this.quantity, this.unitPrice);

  @override
  List<Object?> get props => [name, quantity, unitPrice];
}

class PurchaseDeleted extends PurchaseEvent {
  final String id;

  const PurchaseDeleted(this.id);

  @override
  List<Object?> get props => [id];
}

class SetSpendingLimit extends PurchaseEvent {
  final double? limit;
  const SetSpendingLimit(this.limit);

  @override
  List<Object?> get props => [limit];
}

class PurchasesCleared extends PurchaseEvent {
  const PurchasesCleared();
}

class PurchasesStreamUpdated extends PurchaseEvent {
  final List<dynamic> items;
  const PurchasesStreamUpdated(this.items);

  @override
  List<Object?> get props => [items];
}

class SpendingLimitLoaded extends PurchaseEvent {
  final double? limit;
  const SpendingLimitLoaded(this.limit);

  @override
  List<Object?> get props => [limit];
}

class LimitCleared extends PurchaseEvent {
  const LimitCleared();
}
