import 'dart:async';

import 'package:flutter/material.dart';
import 'package:market_store/store.dart' as market_store;

typedef StateWidgetBuilder<M extends market_store.MarketState> = Widget Function(
    BuildContext context, M state);


class MarketStateWidget<M extends market_store.MarketState> extends StatefulWidget {
  final StateWidgetBuilder<M> build;

  const MarketStateWidget({super.key, required this.build});

  @override
  State<StatefulWidget> createState() => _MarketStateState<M>();
}

class _MarketStateState<M extends market_store.MarketState>
    extends State<MarketStateWidget> {

  late final market_store.MarketState state;
  late final StreamController<market_store.MarketState> controller;

  @override
  void initState() {
    super.initState();

    controller = StreamController<market_store.MarketState>();
    ///Тут иницаиализировать прослушку стейта и перерисовывать при
    ///изменении стейта
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context, state);
  }

  @override
  void dispose() {
    super.dispose();
    /// тут обнулить котроллер прослушки
    controller.close();
  }

  @override
  void didUpdateWidget(covariant MarketStateWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // if(state != controller.stream.last){
    //   state = controller.stream.last;
    // }
  }
}
