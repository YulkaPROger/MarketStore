import 'package:market_store/store.dart';

///СТОР
class AuthStore extends MarketStoreImpl<AuthState, AuthAction, AuthEffect> {
  @override
  AuthState? doAction(AuthAction action, AuthState? oldState) {
    return switch (action) {
      InitialAction() => _initial(action, oldState),
      GetInfoAction() => _getInfo(action, oldState),
      CloseAction() => _close(action, oldState),
      ChangeStateAction() => _changeState(action, oldState),
    };
  }

  _initial(InitialAction action, AuthState? oldState) {
    return InitialState();
  }

  _getInfo(GetInfoAction action, AuthState? oldState) {
    Future.delayed(const Duration(seconds: 1), () {
      dispatch(ChangeStateAction("name"));
    });
    return oldState;
  }

  _close(CloseAction action, AuthState? oldState) {
    return const ErrorState(reason: "Конец ");
  }

  _changeState(ChangeStateAction action, AuthState? oldState) {
    return BaseState(name: action.name);
  }
}

///Стейт
sealed class AuthState extends MarketState {}

class InitialState extends AuthState {}

class BaseState implements AuthState {
  final String name;

  const BaseState({required this.name});
}

class ErrorState implements AuthState {
  final String reason;

  const ErrorState({required this.reason});
}

///Еффекты
sealed class AuthEffect extends MarketEffect {}

class ShowMessEffect implements AuthEffect {}

class ShowErrorEffect implements AuthEffect {}

///Действия
sealed class AuthAction extends MarketAction {}

class InitialAction implements AuthAction {}

class GetInfoAction implements AuthAction {}

class CloseAction implements AuthAction {}

class ChangeStateAction implements AuthAction {
  final String name;

  ChangeStateAction(this.name);
}
