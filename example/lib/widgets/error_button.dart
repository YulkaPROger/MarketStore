import 'package:example/state_manager/example_store.dart';
import 'package:flutter/material.dart';
import 'package:market_store/market_store_widget.dart';

class ErrorButton extends StatelessWidget {
  const ErrorButton({super.key});

  @override
  Widget build(BuildContext context) {
    final CleanerStore scope = MarketStateScope.of<CleanerStore>(context).store;

    return TextButton(
      onPressed: () {
        scope.dispatch(ErrorAction());
      },
      child: const Text("На экран ошибки"),
    );
  }
}
