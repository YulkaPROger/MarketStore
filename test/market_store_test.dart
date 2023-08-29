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
      'Не рабочий тест на Store',
      () {
        final authStore = AuthStore();

        authStore.observeState().listen((event) async {
          await authStore.dispatch(Initial());
          expect(
            authStore.observeState(),
            emitsInOrder([const BaseState(name: "jgvutf")]),
          );
        });
      },
    );
  });
}
