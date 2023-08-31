part of 'example_store.dart';

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

