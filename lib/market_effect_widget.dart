import 'package:flutter/material.dart';
import 'package:market_store/store.dart';

import 'market_store_widget.dart';

typedef MarketStateCallback<E extends MarketEffect> = Widget? Function(E);

class ObserveEffectMarketScope<M extends MarketStore> extends StatelessWidget {
  final MarketStateCallback onChangeEffect;

  const ObserveEffectMarketScope({super.key, required this.onChangeEffect});

  @override
  Widget build(BuildContext context) {
    final M scope = MarketStateScope.of<M>(context).store;

    return StreamBuilder<MarketEffect>(
      stream: scope.observeEffect(),
      builder: (context, snapshot) {
        const emptyWidget = SizedBox.shrink();
        return snapshot.data != null
            ? onChangeEffect(snapshot.data!) ?? emptyWidget
            : emptyWidget;
      },
    );
  }
}
