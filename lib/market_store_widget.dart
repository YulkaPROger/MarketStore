import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:market_store/store.dart';

part 'market_effect_widget.dart';

part 'market_state_widget.dart';

typedef MarketEffectCallback<E extends MarketEffect> = void Function(E);
typedef MarketStateCallback<S extends MarketState> = Widget? Function(S);

class MarketStateScope<T> extends InheritedWidget {
  final T store;

  MarketStateScope({
    super.key,
    required this.store,
    required Widget child,
    MarketAction? initialState,
  }) : super(child: child) {
    if (initialState != null) {
      if (store is MarketStore) {
        (store as MarketStore).dispatch(initialState);
      }
    }
  }

  static MarketStateScope of<T>(BuildContext context) {
    final result = maybeOf<T>(context);
    assert(result != null, 'No MarketStateScope<$T> found in context');
    return result!;
  }

  static MarketStateScope<T>? maybeOf<T>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MarketStateScope<T>>();
  }

  @override
  bool updateShouldNotify(MarketStateScope oldWidget) {
    return store != oldWidget.store;
  }
}
