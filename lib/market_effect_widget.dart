import 'package:flutter/material.dart';
import 'package:market_store/store.dart';
import 'market_store_widget.dart';

typedef MarketStateCallback = void Function(MarketEffect);

class ObserveEffectWidget<M extends MarketState> extends StatelessWidget {
  final MarketStateWidget stateWidget;
  final MarketStateCallback onChangeEffect;

  const ObserveEffectWidget(
      {super.key, required this.stateWidget, required this.onChangeEffect});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stateWidget.store.observeEffect(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          onChangeEffect(snapshot.data!);
        }
        return const SizedBox();
      },
    );
  }
}