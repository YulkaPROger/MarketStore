import 'AuthStore.dart';

void main() {
  final store = AuthStore();

  store.observeState().listen((state) {
    switch (state) {
      case InitialState():
        print('ПОДПИСЧИК initial state');
      case BaseState():
        print('ПОДПИСЧИК base state ${state.name}');
      case ErrorState():
        print('ПОДПИСЧИК error state ${state.reason}');
      default:
        print('ПОДПИСЧИК not state');
    }

    print('observe state $state');
  });

  store.dispatch(GetInfo());
  store.dispatch(ChangeState("hello"));

  store.observeState().listen((state) {
    /// НА ЭТОТ СЛУЧАЙ НАПИСАТЬ ТЕСТЫ!!!
    switch (state) {
      case InitialState():
        print('ЕЩЁ ОДИН ПОДПИСЧИК  initial state');
      case BaseState():
        print('ЕЩЁ ОДИН ПОДПИСЧИК base state ${state.name}');
      case ErrorState():
        print('ЕЩЁ ОДИН ПОДПИСЧИК error state ${state.reason}');
      default:
        print('ЕЩЁ ОДИН ПОДПИСЧИК not state');
    }

    print('observe state $state');
  });

  store.dispatch(Close());

}
