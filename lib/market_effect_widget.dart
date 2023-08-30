part of 'market_store_widget.dart';

class ObserveEffectMarketScope<M extends MarketStore> extends StatelessWidget {
  final MarketEffectCallback onChangeEffect;

  const ObserveEffectMarketScope({super.key, required this.onChangeEffect});

  @override
  Widget build(BuildContext context) {
    final M scope = MarketStateScope.of<M>(context).store;

    return StreamBuilder<MarketEffect>(
      stream: scope.observeEffect(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          onChangeEffect(snapshot.data!);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
