part of 'example_store.dart';

///Стейт

sealed class CleanerState extends MarketState {}

class InitialState extends CleanerState {}

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
