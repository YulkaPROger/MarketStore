import 'dart:async';

import 'package:test/test.dart';

import '../example/AuthStore.dart';

void main() {
  group("description", () {
    test("description", () {
      final testSubject = StreamController<int>();

      testSubject.add(1);

      expect(testSubject.stream, emitsInOrder([1]));
    });
    test(
      'Initial state',
      () async {
        final authStore = AuthStore();

        authStore.observeState().listen((event) {
          expectAsync1(
                (event) {
              expect(event, const BaseState(name: "name"));
            },
          );

        });

        // expect(
        //     streamController.stream,
        //     emitsInOrder([
        //       isA<InitialState>(),
        //     ]));
      },
    );
  });
}
