library market_store;
import 'dart:async';
import 'dart:developer';

part 'store_impl.dart';

abstract class MarketStore<S extends MarketState, A extends MarketAction,
    E extends MarketEffect>  {

  Stream<S?> observeState();

  Stream<E> observeEffect();

  dispatch(A newAction);
}

sealed class BaseMarketStore {}

abstract class MarketState implements BaseMarketStore {}

abstract class MarketEffect implements BaseMarketStore {}

abstract class MarketAction implements BaseMarketStore {}
