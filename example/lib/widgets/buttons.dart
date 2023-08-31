import 'package:example/routes/second_route.dart';
import 'package:example/state_manager/example_store.dart';
import 'package:flutter/material.dart';
import 'package:market_store/market_store_widget.dart';
import 'dart:math' as math;

class Buttons extends StatelessWidget {
  const Buttons({super.key});

  @override
  Widget build(BuildContext context) {
    final CleanerStore scope = MarketStateScope.of<CleanerStore>(context).store;
    const textStyle = TextStyle(
      color: Colors.white,
    );
    final buttonStyle = TextButton.styleFrom(
      backgroundColor: Colors.deepPurple,
    );
    var random = math.Random();

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            scope.dispatch(InitialAction());
          },
          style: buttonStyle,
          child: const Text(
            "Начальное состояние",
            style: textStyle,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextButton(
          onPressed: () {
            scope.dispatch(
                ChangeStateCleanerAction(charge: random.nextInt(300)));
          },
          style: buttonStyle,
          child: const Text(
            "Изменить уровень заряда на рандом",
            style: textStyle,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextButton(
          onPressed: () {
            scope.dispatch(GetInfoAction());
          },
          style: buttonStyle,
          child: const Text(
            "Отложенная операция из сети",
            style: textStyle,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecondRoute()),
            );
          },
          style: buttonStyle,
          child: const Text(
            "Сходим на другую страницу",
            style: textStyle,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextButton(
          onPressed: () {
            scope.dispatch(CloseAction());
          },
          style: buttonStyle,
          child: const Text(
            "Событие показа снекбара",
            style: textStyle,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
