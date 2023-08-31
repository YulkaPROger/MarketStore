part of 'example_store.dart';

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
