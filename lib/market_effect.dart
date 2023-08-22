import 'package:flutter/material.dart';
import 'package:market_store/store.dart' as market_store;

class MarketEffectWidget<M extends market_store.MarketEffect> extends StatefulWidget {
  const MarketEffectWidget({super.key});

  @override
  State<StatefulWidget> createState() => _MarketEffectWidgetState<M>();
}

class _MarketEffectWidgetState<M extends market_store.MarketEffect> extends State<MarketEffectWidget> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  @override
  void initState() {
    super.initState();


  }

  @override
  void dispose() {
    super.dispose();


  }


}