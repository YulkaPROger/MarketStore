import 'package:flutter/material.dart';

class MarketStateScope<T> extends InheritedWidget {
  final T store;

  const MarketStateScope({
    super.key,
    required this.store,
    required Widget child,
  }) : super(child: child);

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
