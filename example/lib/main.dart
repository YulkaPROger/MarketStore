import 'package:example/state_manager/example_store.dart';
import 'package:example/widgets/base_state.dart';
import 'package:example/widgets/buttons.dart';
import 'package:example/widgets/error_state_widget.dart';
import 'package:example/widgets/progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:market_store/market_store_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final store = CleanerStore<CleanerState, CleanerAction, CleanerEffect>();
    // store.dispatch(InitialAction());

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MarketStateScope<CleanerStore>(
        store: store,
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CleanerStore scope = MarketStateScope.of<CleanerStore>(context).store;

    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return ObserveEffectMarketScope<CleanerStore>(
      onChangeEffect: (effect) {
        if (effect is ShowMessEffect) {
          _showSnackBar(context, effect);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("title"),
        ),
        key: scaffoldKey,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ObserveStateMarketScope<CleanerStore>(
                onChangeState: (state) {
                  switch (state) {
                    case BaseState():
                      return BaseStateWidget(
                        state: state,
                      );
                    case ErrorState():
                      return ErrorStateWidget(state: state, scope: scope);
                  }
                  return null;
                },
              ),
              ObserveStateMarketScope<CleanerStore>(
                onChangeState: (state) {
                  if (state is BaseState) {
                    if (state.loaded) {
                      return const ProgressWidget();
                    }
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        floatingActionButton: const Buttons(),
      ),
    );
  }

  void _showSnackBar(
    BuildContext context,
    ShowMessEffect effect,
  ) {
    final snackBar = SnackBar(
      content: Text(effect.mess),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {},
      ),
    );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }
}
