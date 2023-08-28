import 'package:flutter/material.dart';
import 'package:market_store/store.dart';

import 'market_store_widget.dart';

typedef MarketStateCallback<S extends MarketState> = Widget? Function(S);

class ObserveStateMarketScope<M extends MarketStore> extends StatelessWidget {
  final MarketStateCallback onChangeState;

  const ObserveStateMarketScope({super.key, required this.onChangeState});

  @override
  Widget build(BuildContext context) {
    final M scope = MarketStateScope.of<M>(context).store;
    return StreamBuilder(
      stream: scope.observeState(),
      builder: (context, snapshot) {
        const emptyWidget = SizedBox.shrink();
        return snapshot.data != null
            ? onChangeState(snapshot.data!) ?? emptyWidget
            : emptyWidget;
      },
    );
  }
}
