import 'dart:async';

import 'package:test/test.dart';

import '../example/AuthStore.dart';

void main() {
  group("Запуск всех тестов", () {
    test("Рабочий тест на потоках", () {
      final testSubject = StreamController<int>();

      testSubject.add(1);

      expect(testSubject.stream, emitsInOrder([1]));
    });
    test(
      'Рабочий тест на Store',
      () {
        final authStore = AuthStore();
        final stream = authStore.observeState();

        authStore.dispatch(InitialAction());
        authStore.dispatch(GetInfoAction());
        authStore.dispatch(ChangeStateAction("hello"));
        authStore.dispatch(CloseAction());

        expect(
          stream,
          emitsInOrder(
            [
              predicate<InitialState>((s) => s.runtimeType == InitialState),
              predicate<BaseState>((s) => s.name == 'hello'),
              predicate<ErrorState>((s) => s.reason == "Конец "),
            ],
          ),
        );

      },
    );
  });
}
