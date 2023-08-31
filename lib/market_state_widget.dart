part of 'market_store_widget.dart';

class ObserveStateMarketScope<M extends MarketStore> extends StatelessWidget {
  final MarketStateCallback onChangeState;

  const ObserveStateMarketScope({super.key, required this.onChangeState});

  @override
  Widget build(BuildContext context) {
    final M scope = MarketStateScope.of<M>(context).store;
    return StreamBuilder(
      stream: scope.observeState().stream,
      builder: (context, snapshot) {
        const emptyWidget = SizedBox.shrink();
        return snapshot.data != null
            ? onChangeState(snapshot.data!) ?? emptyWidget
            : emptyWidget;
      },
    );
  }
}
