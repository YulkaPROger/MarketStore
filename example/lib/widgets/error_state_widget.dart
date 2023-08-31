import 'package:example/state_manager/example_store.dart';
import 'package:flutter/material.dart';

class ErrorStateWidget extends StatelessWidget {
  final ErrorState state;
  final CleanerStore scope;
  const ErrorStateWidget({super.key, required this.state, required this.scope});

  @override
  Widget build(BuildContext context) {

    const textStyle = TextStyle(
      color: Colors.white,
    );
    final buttonErrorStyle = TextButton.styleFrom(
      backgroundColor: Colors.redAccent,
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        onPressed: () {
          scope.dispatch(ShowMessAction("Кина не будет"));
        },
        style: buttonErrorStyle,
        child: Text(
          "Показывается только когда состояние в Error State, "
              "нажатие эмитит показ снек бара ${state.reason}",
          style: textStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
