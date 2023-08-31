part of 'store.dart';

abstract class MarketStoreImpl<S extends MarketState, A extends MarketAction,
    E extends MarketEffect> extends MarketStore<S, A, E> {
  final StreamController<S?> _state = StreamController.broadcast();

  final StreamController<A> _action = StreamController();

  final StreamController<E> _effect = StreamController.broadcast();
  S? _oldState;

  @override
  StreamController<E> observeEffect() {
    return _effect;
  }

  @override
  StreamController<S?> observeState() {
    return _state;
  }

  @override
  dispatch(A newAction) {
    _action.add(newAction);
  }

  sendEffect(E newEffect) {
    _effect.add(newEffect);
  }

  MarketStoreImpl() {
    _action.stream.listen((action) {
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
