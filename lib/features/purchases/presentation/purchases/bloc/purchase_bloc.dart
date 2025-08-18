// features/purchases/presentation/bloc/purchase_bloc.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shopping/features/purchases/domain/entities/purchase.dart';
import 'package:shopping/features/purchases/domain/usecases/add_purchase_use_case.dart';
import 'package:shopping/features/purchases/domain/usecases/clear_purchases_use_case.dart';
import 'package:shopping/features/purchases/domain/usecases/delete_purchase_use_case.dart';
import 'package:shopping/features/purchases/domain/usecases/get_all_purchases_use_case.dart';
import 'package:uuid/uuid.dart';
import 'purchase_event.dart';
import 'purchase_state.dart';

class PurchaseBloc extends Bloc<PurchaseEvent, PurchaseState> {
  final GetAllPurchasesUseCase getAllPurchasesUseCase;
  final AddPurchaseUseCase addPurchaseUseCase;
  final DeletePurchaseUseCase deletePurchaseUseCase;
  final ClearPurchasesUseCase clearPurchasesUseCase;

  StreamSubscription<List<Purchase>>? _sub;
  final _uuid = const Uuid();

  PurchaseBloc({
    required this.getAllPurchasesUseCase,
    required this.addPurchaseUseCase,
    required this.deletePurchaseUseCase,
    required this.clearPurchasesUseCase,
  }) : super(const PurchaseState(loading: true)) {
    on<PurchaseStarted>(_onStarted);
    on<PurchaseAdded>(_onAdded);
    on<PurchaseDeleted>(_onDeleted);
    on<PurchaseCleared>(_onCleared);
    on<PurchasesStreamUpdated>(_onStreamUpdated);
  }

  void _onStarted(PurchaseStarted event, Emitter<PurchaseState> emit) {
    emit(state.copyWith(loading: true, error: null));
    _sub?.cancel();
    _sub = getAllPurchasesUseCase().listen(
      (items) => add(PurchasesStreamUpdated(items)),
      onError: (e, _) =>
          emit(state.copyWith(loading: false, error: e.toString())),
    );
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
      (l) => emit(state.copyWith(error: l.toString())),
      (_) {},
    );
  }

  Future<void> _onDeleted(
      PurchaseDeleted e, Emitter<PurchaseState> emit) async {
    final res = await deletePurchaseUseCase(e.id);
    res.fold(
      (l) => emit(state.copyWith(error: l.toString())),
      (_) {},
    );
  }

  Future<void> _onCleared(
      PurchaseCleared e, Emitter<PurchaseState> emit) async {
    final res = await clearPurchasesUseCase();
    res.fold(
      (l) => emit(state.copyWith(error: l.toString())),
      (_) {},
    );
  }

  void _onStreamUpdated(PurchasesStreamUpdated e, Emitter<PurchaseState> emit) {
    final items = e.items.cast<Purchase>();
    emit(PurchaseState(items: items, loading: false));
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    return super.close();
  }
}
