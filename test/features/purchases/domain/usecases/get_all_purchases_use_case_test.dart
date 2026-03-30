import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shopping/features/purchases/domain/usecases/purchases/get_all_purchases_use_case.dart';

import '../../../../helpers/dummy_data.dart';
import '../../../../helpers/mocks.dart';

void main() {
  late MockPurchaseRepository repo;
  late GetAllPurchasesUseCase usecase;
  late StreamController<List<dynamic>> controller;

  setUp(() {
    repo = MockPurchaseRepository();
    usecase = GetAllPurchasesUseCase(repo);
    controller = StreamController<List<dynamic>>();
  });

  tearDown(() async {
    await controller.close();
  });

  test('emit list from repository', () async {
    when(() => repo.getAll())
        .thenAnswer((_) => controller.stream.map((e) => e.cast()));

    final emitted = <List<dynamic>>[];
    final sub = usecase().listen(emitted.add);

    controller.add([p1(), p2()]);
    await Future<void>.delayed(const Duration(milliseconds: 100));

    expect(emitted.length, 1);
    expect(emitted.first.length, 2);

    await sub.cancel();
  });
}
