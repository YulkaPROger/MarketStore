import 'package:market_store/store.dart';
import 'package:market_store/store_impl.dart';

///СТОР
class AuthStore extends StoreImpl<AuthState, AuthAction, AuthEffect> {
  @override
  AuthState doAction(AuthAction action, AuthState? oldState) {
    return switch (action) {
      Initial() => _initial(action, oldState),
      GetInfo() => _getInfo(action, oldState),
      Close() => _close(action, oldState),
      ChangeState() => _changeState(action, oldState),
    };
  }

  _initial(AuthAction action, AuthState? oldState) {
    print('_initial');
    return InitialState();
  }

  _getInfo(AuthAction action, AuthState? oldState) {
    print('_getInfo');
    return InitialState();
  }

  _close(AuthAction action, AuthState? oldState) {
    print('_close');
    return const ErrorState(reason: "Конец ");
  }

  _changeState(AuthAction action, AuthState? oldState) {
    print('_changeState');
    return const BaseState(name: "name");
  }

  AuthStore() {
    print('init');
    dispatch(Initial());
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

class ShowMess implements AuthEffect {}

class ShowError implements AuthEffect {}

///Действия
sealed class AuthAction extends MarketAction {}

class Initial implements AuthAction {}

class GetInfo implements AuthAction {}

class Close implements AuthAction {}

class ChangeState implements AuthAction {
  final String name;

  ChangeState(this.name);
}