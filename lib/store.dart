library market_store;

import 'dart:async';

abstract class MarketStore<S extends MarketState, A extends MarketAction,
    E extends MarketEffect>  {
  // StreamController<S> get state;
  // StreamController<E> get effect;
  // StreamController<A> get action;

  Stream<S?> observeState();

  Stream<E> observeEffect();

  dispatch(A newAction);
}

sealed class BaseMarketStore {}

abstract class MarketState implements BaseMarketStore {}

abstract class MarketEffect implements BaseMarketStore {}

abstract class MarketAction implements BaseMarketStore {}
