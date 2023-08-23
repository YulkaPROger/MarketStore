import 'package:flutter/cupertino.dart';
import 'package:market_store/store_impl.dart';

class MarketStateWidget extends InheritedWidget {
  final StoreImpl store;

  final Widget child;

  const MarketStateWidget({super.key, required this.store, required this.child})
      : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static MarketStateWidget? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MarketStateWidget>();
}
