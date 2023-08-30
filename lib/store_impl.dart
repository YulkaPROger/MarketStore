part of 'store.dart';

abstract class StoreImpl<S extends MarketState, A extends MarketAction,
    E extends MarketEffect> extends MarketStore<S, A, E> {
  final StreamController<S?> _state = StreamController.broadcast(sync: true);

  final StreamController<A> _action = StreamController(sync: true);

  final StreamController<E> _effect = StreamController.broadcast(sync: true);
  S? _oldState;

  @override
  Stream<E> observeEffect() {
    return _effect.stream;
  }

  @override
  Stream<S?> observeState() {
    return _state.stream;
  }

  @override
  dispatch(A newAction) {
    _action.add(newAction);
  }

  sendEffect(E newEffect) {
    _effect.add(newEffect);
  }

  StoreImpl() {
    _action.stream.listen((action) {
      log("listen action $action", name: "MarketStore");
      _dispatchAction(action);
    });
  }

  _dispatchAction(A action) async {
    log("start action $action", name: "MarketStore");
    try {
      final newState = doAction(action, _oldState);

      if (newState != _oldState) {
        log("end newState: $newState", name: "MarketStore");

        _state.add(newState);
        _oldState = newState;
      } else {
        log("newState equals oldState", name: "MarketStore");
      }
    } catch (_) {
      log("failure dispatch $action", name: "MarketStore");
    }
  }

  S? doAction(A action, S? oldState);
}
