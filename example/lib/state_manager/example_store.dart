import 'package:market_store/store.dart';
import 'package:example/models/flat.dart';
import 'package:example/models/room.dart';
import 'package:example/models/vacuum_cleaner.dart';

part 'actions.dart';

part 'effects.dart';

part 'states.dart';

///СТОР

class CleanerStore<S, A, E>
    extends MarketStoreImpl<CleanerState, CleanerAction, CleanerEffect> {

  // CleanerStore(){
  //   dispatch(InitialAction());
  // }

  @override
  CleanerState doAction(CleanerAction action, CleanerState? oldState) {
    return switch (action) {
      InitialAction() => _initial(action, oldState),
      GetInfoAction() => _getInfo(action, oldState),
      CloseAction() => _close(action, oldState),
      ChangeStateCleanerAction() => _changeState(action, oldState),
      ShowMessAction() => _showMess(action, oldState),
      ErrorAction() => const ErrorState(reason: "Так захотел пользователь"),
    };
  }

  _initial(InitialAction action, CleanerState? oldState) {
    return BaseState(
      flat: Flat(
        rooms: List.of([
          Room(name: "Спальня", square: 20.2),
          Room(name: "Гостинная", square: 50.4),
          Room(name: "Кухня", square: 5.8),
        ]),
      ),
      vacuumCleaner: VacuumCleaner(
          name: 'Robot',
          isFull: true,
          charge: 100,
          commands: List.of(["Гулять", "Спать", "Убирать"]),
          serviceDate: "32.12.1803"),
    );
  }

  _getInfo(GetInfoAction action, CleanerState? oldState) {
    Future.delayed(const Duration(seconds: 5), () {
      dispatch(ChangeStateCleanerAction(isEmpty: false, charge: 500));
    });
    if (oldState is BaseState) {
      return oldState.copyWith(loaded: true);
    } else {
      return oldState;
    }
  }

  _close(CloseAction action, CleanerState? oldState) {
    sendEffect(ShowMessEffect("Приплыли"));
    if (oldState is BaseState) {
      return oldState.copyWith(errorButton: true);
    } else {
      return oldState;
    }
  }

  _changeState(ChangeStateCleanerAction action, CleanerState? oldState) {
    if (oldState is BaseState) {
      final newVacuumCleaner = oldState.vacuumCleaner.copyWith(
        isFull: action.isEmpty ?? oldState.vacuumCleaner.isFull,
        charge: action.charge ?? oldState.vacuumCleaner.charge,
      );
      return oldState.copyWith(vacuumCleaner: newVacuumCleaner, loaded: false);
    }
  }

  _showMess(ShowMessAction action, CleanerState? oldState) {
    sendEffect(ShowMessEffect(action.mess));
    return oldState;
  }
}
