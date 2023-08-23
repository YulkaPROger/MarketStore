import 'package:flutter/material.dart';
import 'package:market_store/store.dart';
import 'market_state_widget.dart';

typedef MarketStateCallback = void Function(MarketState);

class ObserveStateWidget<M extends MarketState> extends StatelessWidget {
  final MarketStateWidget stateWidget;
  final MarketStateCallback onChangeState;

  const ObserveStateWidget(
      {super.key, required this.stateWidget, required this.onChangeState});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stateWidget.store.observeState(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          onChangeState(snapshot.data! as MarketState); /// ГАВНО!!!
        }
        return const SizedBox();
      },
    );
  }
}

