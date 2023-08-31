library market_store;
import 'dart:async';
import 'dart:developer';

part 'store_impl.dart';

abstract class MarketStore<S extends MarketState, A extends MarketAction,
    E extends MarketEffect>  {

  StreamController<S?> observeState();

  StreamController<E> observeEffect();

  dispatch(A newAction);
}

sealed class BaseMarketStore {}

abstract class MarketState implements BaseMarketStore {}

abstract class MarketEffect implements BaseMarketStore {}

abstract class MarketAction implements BaseMarketStore {}
