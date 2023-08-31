import 'package:market_store/store.dart';

import '../models/flat.dart';
import '../models/room.dart';
import '../models/vacuum_cleaner.dart';
import 'constants.dart';

class CleanerStore<S, A, E>
    extends MarketStoreImpl<CleanerState, CleanerAction, CleanerEffect> {
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
    if (oldState is BaseState) {
      final vacuumCleaner = oldState.vacuumCleaner
          .copyWith(isFull: false, charge: Constants.charge);
      return oldState.copyWith(loaded: true, vacuumCleaner: vacuumCleaner);
    } else {
      return oldState;
    }
  }

  _close(CloseAction action, CleanerState? oldState) {
    sendEffect(ShowMessEffect(Constants.sailed));
    return ErrorState(reason: Constants.cancel);
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

///Стейт

sealed class CleanerState extends MarketState {}

class BaseState implements CleanerState {
  final Flat flat;
  final VacuumCleaner vacuumCleaner;
  final bool loaded;
  final bool errorButton;

  const BaseState({
    required this.flat,
    required this.vacuumCleaner,
    this.loaded = false,
    this.errorButton = false,
  });

  BaseState copyWith({
    VacuumCleaner? vacuumCleaner,
    bool? loaded,
    bool? errorButton,
  }) =>
      BaseState(
        flat: flat,
        vacuumCleaner: vacuumCleaner ?? this.vacuumCleaner,
        loaded: loaded ?? this.loaded,
        errorButton: errorButton ?? this.errorButton,
      );
}

class ErrorState implements CleanerState {
  final String reason;

  const ErrorState({required this.reason});
}

///Действия

sealed class CleanerAction extends MarketAction {}

class InitialAction implements CleanerAction {}

class GetInfoAction implements CleanerAction {}

class CloseAction implements CleanerAction {}

class ErrorAction implements CleanerAction {}

class ChangeStateCleanerAction implements CleanerAction {
  final bool? isEmpty;
  final int? charge;

  ChangeStateCleanerAction({this.isEmpty, this.charge});
}

class ShowMessAction implements CleanerAction {
  final String mess;

  ShowMessAction(this.mess);
}

///Еффекты

sealed class CleanerEffect extends MarketEffect {}

class ShowMessEffect implements CleanerEffect {
  final String mess;

  ShowMessEffect(this.mess);
}

class ShowErrorEffect implements CleanerEffect {}

class NavigateToEffect implements CleanerEffect {
  final String route;

  NavigateToEffect({required this.route});
}
