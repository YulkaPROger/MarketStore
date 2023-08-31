import 'package:example/state_manager/example_store.dart';
import 'package:flutter/material.dart';
import 'error_button.dart';

class BaseStateWidget extends StatelessWidget {
  final BaseState state;

  const BaseStateWidget({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    const text2style = TextStyle(
      fontSize: 16,
      color: Colors.black,
      fontWeight: FontWeight.w700,
    );
    const text3style = TextStyle(
      fontSize: 24,
      color: Colors.deepPurple,
      fontWeight: FontWeight.w700,
    );
    const text4style = TextStyle(
      fontSize: 30,
      color: Colors.pink,
      fontWeight: FontWeight.w700,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        state.errorButton ? const ErrorButton() : const SizedBox.shrink(),
        const Text(
          "Имя пылесоса",
          style: text2style,
          textAlign: TextAlign.center,
        ),
        Text(
          state.vacuumCleaner.name,
          style: text3style,
          textAlign: TextAlign.center,
        ),
        const Text(
          "Полный?}",
          style: text2style,
        ),
        Text(
          state.vacuumCleaner.isFull.toString(),
          style: state.vacuumCleaner.isFull ? text3style : text4style,
          textAlign: TextAlign.center,
        ),
        const Text(
          "Дата след обслуживания",
          style: text2style,
        ),
        Text(
          state.vacuumCleaner.serviceDate,
          style: text3style,
          textAlign: TextAlign.center,
        ),
        const Text(
          "Уровень заряда",
          style: text2style,
        ),
        Text(
          state.vacuumCleaner.charge.toString(),
          style: state.vacuumCleaner.charge == 100 ? text3style : text4style,
          textAlign: TextAlign.center,
        ),
        const Text(
          "Список команд",
          style: text2style,
        ),
        Text(
          state.vacuumCleaner.commands.toString(),
          style: text3style,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
