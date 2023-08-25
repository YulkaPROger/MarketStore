import 'package:flutter/cupertino.dart';
import 'package:market_store/store.dart';

class MarketStateWidget<M extends MarketStore> extends InheritedWidget {
  final M store;

  final Widget child;

  const MarketStateWidget({super.key, required this.store, required this.child})
      : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static MarketStateWidget? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MarketStateWidget>();
}
