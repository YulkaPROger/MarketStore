import 'dart:async';

import 'package:market_store/store.dart';

// mixin Func<E extends MarketEffect>{
//   Stream<E> observeEffect() {
//     print('observeEffect');
//     return _effect.stream;
//   }
// }

abstract class StoreImpl<S extends BaseMarketStore, A extends BaseMarketStore,
    E extends BaseMarketStore> extends MarketStore<S, A, E> {
  final StreamController<S?> _state = StreamController.broadcast(sync: true);

  final StreamController<A> _action = StreamController(sync: true);

  final StreamController<E> _effect = StreamController.broadcast(sync: true);
  S? _oldState;

  @override
  Stream<E> observeEffect() {
    print('observeEffect');
    return _effect.stream;
  }

  @override
  Stream<S?> observeState() {
    print('observeState');
    return _state.stream;
  }

  @override
  dispatch(A newAction) {
    print('dispatch $newAction');
    _action.add(newAction);
  }

  sendEffect(E newEffect) {
    print('sendEffect $newEffect');
    _effect.add(newEffect);
  }

  StoreImpl() {
    print('initial listen stream');
    _action.stream.listen((action) {
      print('listen action $action');
      // log("listen action $action", name: "MarketStore");

      /// листенер не срабатывает
      _dispatchAction(action);
    });
  }

  _dispatchAction(A action) async {
    print("start action $action");
    // log("start action $action", name: "MarketStore");
    try {

      final newState = doAction(action, _oldState);
      print('new state $newState');

      if (newState != _oldState) {
        print("end newState: $newState");
        // log("end newState: $newState", name: "MarketStore");

        _state.add(newState);
        _oldState = newState;
      }

    } catch (_) {
      print("failure dispatch $action");
      // log("failure dispatch $action", name: "MarketStore");
    }
  }

  S doAction(A action, S? oldState);

}
