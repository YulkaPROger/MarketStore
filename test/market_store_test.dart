import 'dart:async';

import 'package:test/test.dart';

import 'mock_store/constants.dart';
import 'mock_store/mock_store.dart';

void main() {
  test(
    'Инициализация стора без состояния',
    () {
      final cleanerStore = CleanerStore();
      final Stream<CleanerState?> stream = cleanerStore.observeState().stream;

      expect(
        stream,
        emitsInOrder(
          [],
        ),
      );
    },
  );

  test(
    'Инициализация стора c начальным состоянием BaseState',
    () {
      final cleanerStore = CleanerStore();
      cleanerStore.dispatch(InitialAction());
      final Stream<CleanerState?> stream = cleanerStore.observeState().stream;

      expect(
        stream,
        emitsInOrder(
          [
            predicate<BaseState>((s) => s.runtimeType == BaseState),
          ],
        ),
      );
    },
  );

  test(
    'Последовательность стейтов = BaseState, BaseState c зарядом 500, '
    'и isEmpty = false, а затем ErrorState',
    () {
      final cleanerStore = CleanerStore();
      cleanerStore.dispatch(InitialAction());
      cleanerStore.dispatch(GetInfoAction());
      cleanerStore.dispatch(CloseAction());
      final Stream<CleanerState?> stream = cleanerStore.observeState().stream;

      expect(
        stream,
        emitsInOrder(
          [
            predicate<BaseState>((s) => s.runtimeType == BaseState),
            predicate<BaseState>((s) {
              return s.vacuumCleaner.charge == Constants.charge &&
                  !s.vacuumCleaner.isFull;
            }),
            predicate<ErrorState>((s) => s.reason == Constants.cancel),
          ],
        ),
      );
    },
  );

  test(
    'Прослушка еффекта стора',
    () {
      final cleanerStore = CleanerStore();
      cleanerStore.dispatch(ShowMessAction(Constants.sailed));
      final Stream<CleanerEffect?> stream = cleanerStore.observeEffect().stream;

      expect(
        stream,
        emitsInOrder(
          [
            predicate<ShowMessEffect>((s) {
              return s.mess == Constants.sailed;
            }),
          ],
        ),
      );
    },
  );

  test(
    'Прослушка нескольких еффектов стора',
        () {
      final cleanerStore = CleanerStore();
      cleanerStore.dispatch(ShowMessAction(Constants.sailed));
      cleanerStore.dispatch(ShowMessAction(Constants.loremIpsum));
      cleanerStore.dispatch(ShowMessAction(Constants.sailed));
      final Stream<CleanerEffect?> stream = cleanerStore.observeEffect().stream;

      expect(
        stream,
        emitsInOrder(
          [
            predicate<ShowMessEffect>((s) {
              return s.mess == Constants.sailed;
            }),
            predicate<ShowMessEffect>((s) {
              return s.mess == Constants.loremIpsum;
            }),
            predicate<ShowMessEffect>((s) {
              return s.mess == Constants.sailed;
            }),
          ],
        ),
      );
    },
  );
}
