import 'AuthStore.dart';

void main() {
  final st = AuthStore();

  st.observeState().listen((state) {
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

  st.dispatch(GetInfo());
  st.dispatch(ChangeState("hello"));

  st.observeState().listen((state) {
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

  st.dispatch(Close());

  // MarketStateWidget(
  //   build: (BuildContext context, AuthState state) {
  //     if (state is InitialState){
  //
  //     }
  //     return Text("ghhb");
  //   },
  // );
}
