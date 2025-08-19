// features/purchases/presentation/bloc/purchase_bloc.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shopping/features/purchases/domain/entities/purchase.dart';
import 'package:shopping/features/purchases/domain/usecases/purchases/add_purchase_use_case.dart';
import 'package:shopping/features/purchases/domain/usecases/purchases/clear_purchases_use_case.dart';
import 'package:shopping/features/purchases/domain/usecases/purchases/delete_purchase_use_case.dart';
import 'package:shopping/features/purchases/domain/usecases/purchases/get_all_purchases_use_case.dart';
import 'package:shopping/features/purchases/domain/usecases/purchases/update_purchase_use_case.dart';
import 'package:shopping/features/purchases/domain/usecases/settings/get_spending_limit_use_case.dart';
import 'package:shopping/features/purchases/domain/usecases/settings/set_spending_limit_use_case.dart';
import 'package:uuid/uuid.dart';
import 'purchase_event.dart';
import 'purchase_state.dart';

class PurchaseBloc extends Bloc<PurchaseEvent, PurchaseState> {
  // Purchases
  final GetAllPurchasesUseCase getAllPurchasesUseCase;
  final AddPurchaseUseCase addPurchaseUseCase;
  final UpdatePurchaseUseCase updatePurchaseUseCase;
  final DeletePurchaseUseCase deletePurchaseUseCase;
  final ClearPurchasesUseCase clearPurchasesUseCase;

  // Spending Limit
  final GetSpendingLimitUseCase getSpendingLimitUseCase;
  final SetSpendingLimitUseCase setSpendingLimitUseCase;

  StreamSubscription<List<Purchase>>? _sub;
  final _uuid = const Uuid();

  PurchaseBloc({
    required this.getAllPurchasesUseCase,
    required this.addPurchaseUseCase,
    required this.deletePurchaseUseCase,
    required this.clearPurchasesUseCase,
    required this.getSpendingLimitUseCase,
    required this.setSpendingLimitUseCase,
    required this.updatePurchaseUseCase,
  }) : super(const PurchaseState(loading: true)) {
    on<PurchaseStarted>(_onStarted);
    on<PurchaseAdded>(_onAdded);
    on<PurchaseDeleted>(_onDeleted);
    on<PurchasesCleared>(_onCleared);
    on<PurchasesStreamUpdated>(_onStreamUpdated);
    on<SetSpendingLimit>(_onSetLimit);
    on<SpendingLimitLoaded>(_onLimitLoaded);
    on<LimitCleared>(_onLimitCleared);
    on<PurchaseUpdated>(_onUpdated);
  }

  void _onStarted(PurchaseStarted event, Emitter<PurchaseState> emit) {
    emit(state.copyWith(loading: true, error: null, keepLimit: true));
    unawaited(() async {
      final limit = await getSpendingLimitUseCase();
      add(SpendingLimitLoaded(limit));
    }());
    _sub?.cancel();
    _sub = getAllPurchasesUseCase().listen(
      (items) => add(PurchasesStreamUpdated(items)),
      onError: (e, _) => emit(
          state.copyWith(loading: false, error: e.toString(), keepLimit: true)),
    );
  }

  void _onLimitLoaded(SpendingLimitLoaded e, Emitter<PurchaseState> emit) {
    emit(state.copyWith(spendingLimit: e.limit, keepLimit: false));
  }

  Future<void> _onAdded(PurchaseAdded e, Emitter<PurchaseState> emit) async {
    final purchase = Purchase(
      id: _uuid.v4(),
      name: e.name.trim(),
      quantity: e.quantity,
      unitPrice: e.unitPrice,
      createdAt: DateTime.now(),
    );
    final res = await addPurchaseUseCase(purchase);
    res.fold(
      (l) => emit(state.copyWith(error: l.toString(), keepLimit: true)),
      (_) {},
    );
  }

  Future<void> _onDeleted(
      PurchaseDeleted e, Emitter<PurchaseState> emit) async {
    final res = await deletePurchaseUseCase(e.id);
    res.fold(
      (l) => emit(state.copyWith(error: l.toString(), keepLimit: true)),
      (_) {},
    );
  }

  Future<void> _onCleared(
      PurchasesCleared e, Emitter<PurchaseState> emit) async {
    final res = await clearPurchasesUseCase();
    res.fold(
      (l) => emit(state.copyWith(error: l.toString(), keepLimit: true)),
      (_) {},
    );
  }

  void _onStreamUpdated(PurchasesStreamUpdated e, Emitter<PurchaseState> emit) {
    final items = e.items.cast<Purchase>();
    emit(state.copyWith(
      items: items,
      loading: false,
      error: null,
      keepLimit: true,
    ));
  }

  void _onSetLimit(SetSpendingLimit e, Emitter<PurchaseState> emit) async {
    await setSpendingLimitUseCase(e.limit);
    emit(state.copyWith(
      spendingLimit: e.limit,
      setSpendingLimit: true,
    ));
  }

  void _onLimitCleared(LimitCleared e, Emitter<PurchaseState> emit) async {
    await setSpendingLimitUseCase(null);
    emit(state.copyWith(
      spendingLimit: null,
      setSpendingLimit: true,
    ));
  }

  Future<void> _onUpdated(
      PurchaseUpdated e, Emitter<PurchaseState> emit) async {
    final res = await updatePurchaseUseCase(e.purchase);
    res.fold((l) => emit(state.copyWith(error: l.toString(), keepLimit: true)),
        (_) {});
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    return super.close();
  }
}
